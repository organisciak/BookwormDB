#invoke with any of these variable: eg, `make`

featureDirectory="/data/datasets/htrc-feat-extract/data"
textStream:='printText.sh'
inputFile="/data/datasets/htrc-feat-extract/bookwormFeatureCounts.gz"
source="countfile"

# The maximum size of each input block for parallel processing.
# 100M should be appropriate for a machine with 8-16GB of memory: if you're
# having problems on a smaller machine, try bringing it down.

blockSize:=100M

webDirectory="/var/www/"

#New syntax requires bash
SHELL:=/bin/bash

#You can manually specify a bookworm name, but normally it just greps it out of your configuration file.
bookwormName:=$(shell grep database bookworm.cnf | sed 's/.* = //g')

#The data format may vary depending on how the raw files are stored. The easiest way is to simply pipe out the contents from input.txt: but any other method that produces the same format (a python script that unzips from a directory with an arcane structure, say) is just as good.
#The important thing, I think, is that it not insert EOF markers into the middle of your stream.

webSite = $(addsuffix bookwormName,webDirectory)

all: bookworm.cnf files/targets files/targets/input files/targets/database

bookworm.cnf:
	python scripts/makeConfiguration.py

#These are all directories that need to be in place for the other scripts to work properly
files/targets: 
	mkdir -p files/texts/encoded/{unigrams,bigrams,trigrams,completed}
	mkdir -p files/texts/{textids,wordlist}
	mkdir -p files/{targets,metadata}

#A "make clean" removes most things created by the bookworm,
#but keeps the database and the registry of text and wordids

clean:
	#Remove inputs.txt if it's a pipe.
	find files/texts -maxdepth 1 -type p -delete
	rm -rf files/texts/encoded/*/*
	rm -rf files/targets
	rm -f files/metadata/catalog.txt
	rm -f files/metadata/jsoncatalog.txt
	rm -f files/metadata/jsoncatalog_derived.txt
	rm -f files/metadata/field_descriptions_derived.json
	
# Make 'pristine' is a little more aggressive
# This can be dangerous, but lets you really wipe the slate.

pristine: clean
	-mysql -e "DROP DATABASE $(bookwormName)"
	rm -f files/targets/input	
	rm -rf files/texts/textids
	rm -rf files/texts/wordlist/*

# For HTRC, to process feature files beforehand. 
files/targets/input: files/targets
	date
	# find $(featureDirectory) -name "*json.bz2" | head -n 10000 | parallel -j90% -n10 python scripts/htrc_featurecount_stream.py {} | gzip -c >$(inputFile)
	#find $(featureDirectory) -name "*json.bz2" | parallel -j90% -n10 python scripts/htrc_featurecount_stream.py {} >unigrams.txt
	touch $@

# The wordlist is an encoding scheme for words: it tokenizes in parallel, and should
# intelligently update an exist vocabulary where necessary. It takes about half the time
# just to build this: any way to speed it up is a huge deal.
# The easiest thing to do, of course, is simply use an Ngrams or other wordlist.

files/texts/wordlist/wordlist.txt:
	date
	#scripts/fast_featurecounter.sh $(inputFile) /data/datasets/htrc-feat-extract/tmp1/ $(blockSize)
	scripts/fast_featurecounter.sh unigrams.txt /data/datasets/htrc-feat-extract/tmp1/ $(blockSize)
	date

# This invokes OneClick on the metadata file to create a more useful internal version
# (with parsed dates) and to create a lookup file for textids in files/texts/textids

files/metadata/jsoncatalog.txt:
	date
	find $(featureDirectory) -name "*.json.bz2" | parallel -n 10 python scripts/htrc_makeJSONcatalog.py {} >files/metadata/jsoncatalog.txt
	date

files/metadata/jsoncatalog_derived.txt: files/metadata/jsoncatalog.txt
#Run through parallel as well.
	cat files/metadata/jsoncatalog.txt | parallel --pipe python bookworm/MetaParser.py > $@


# In addition to building files for ingest.

files/metadata/catalog.txt:
	date
	python OneClick.py preDatabaseMetadata
	date

# This is the penultimate step: creating a bunch of tsv files 
# (one for each binary blob) with 3-byte integers for the text
# and word IDs that MySQL can slurp right up.

# This could be modified to take less space/be faster by using named pipes instead
# of pre-built files inside the files/targets/encoded files: it might require having
# hundreds of blocked processes simultaneously, though, so I'm putting that off for now.

# The tokenization script dispatches a bunch of parallel processes to bookworm/tokenizer.py,
# each of which saves a binary file. The cat stage at the beginning here could be modified to 
# check against some list that tracks which texts we have already encoded to allow additions to existing 
# bookworms to not require a complete rebuild.

files/targets/encoded: files/texts/wordlist/wordlist.txt
#builds up the encoded lists that don't exist yet.
#I "Make" the catalog files rather than declaring dependency so that changes to 
#the catalog don't trigger a db rebuild automatically.
	date
	make files/metadata/jsoncatalog_derived.txt
	make files/texts/textids.dbm
	make files/metadata/catalog.txt
	#$(textStream) | parallel --block-size $(blockSize) -u --pipe bookworm/tokenizer.py
	python bookworm/ingestFeatureCounts.py encode
	date
	touch files/targets/encoded

# The database is the last piece to be built: this invocation of OneClick.py
# uses the encoded files already written to disk, and loads them into a database.
# It also throws out a few other useful files at the end into files/

files/targets/database: files/targets/database_wordcounts files/targets/database_metadata 
	date
	touch $@
	date

files/texts/textids.dbm: files/texts/textids files/metadata/jsoncatalog_derived.txt files/metadata/catalog.txt
	date
	python bookworm/makeWordIdDBM.py
	date

files/targets/database_metadata: files/targets/encoded files/texts/wordlist/wordlist.txt files/targets/database_wordcounts files/metadata/jsoncatalog_derived.txt files/metadata/catalog.txt 
	date
	python OneClick.py database_metadata
	date
	touch $@

files/targets/database_wordcounts: files/targets/encoded files/texts/wordlist/wordlist.txt
	date
	python OneClick.py database_wordcounts
	date
	touch $@

# the bookworm json is created as a sideeffect of the database creation: this just makes that explicit for the webdirectory target.
# I haven't yet gotten Make to properly just handle the shuffling around: maybe a python script inside "etc" would do better.

$(webDirectory)/$(bookwormName): files/$(bookwormName).json
	git clone https://github.com/econpy/BookwormGUI $@
	cp files/*.json $@/static/options.json
