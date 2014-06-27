# `input.txt`

### Character encoding

The input should be in UTF-8. (ASCII is a valid subset of UTF-8, and therefore acceptable). Bookworm attempts to warn when skipping words in invalid encodings (many Latin-1 characters, for example), but we cannot guarantee that every strange character will produce the correct result.

## Formatting texts for Bookworm

### The easy route: a single file

The basic and most straightforward file format for input.txt is a single string that serves as an identifier for the text (keyed to the `filename` element in [jsoncatalog.txt](), followed by a tab, followed by the full text of the document, **with all tabs, newlines, and carriage returns removed**.

If your texts have newlines, you will need to remove them before putting them into this format. It is usually best to replace them with spaces. (Or, if you don't want bigrams formed across the break, with the formfeed `\f` character).

An example input.txt might look like this, **except that the `[\t]` characters should be tabs, not the bracket characters you see**. (Sorry: I find myself unable to reproduce literal tabs in this format).

```
TaleOfTwoCities[\t]It was the best of times, It was the worst of times…
AnnaKarenina[\t]Stately, plump, Buck Mulligan is different in his own way, through a commodius vicus of recirculation…
Nagel-1970[\t]Just as there are rational requirements on thought, there are rational requirements on action, and altruism is one of them
```

### More complicated: using a pipe

If you have, for example, several different smaller files in that format you want Bookworm to read in all at once, you could run

```{sh}
mkfifo texts/input.txt
cat mytextfolder.* > texts/input.txt &
make database bookwormName=OL
```

The `&` after the cat statement lets you move on to actually doing a process: otherwise, it will simply hang indefinitely, waiting for some process to come along and read the contents.

### Most flexible: specify a path.

They said you could have a Model T in any color you liked, as long as it was black. Bookworm is happy to work with texts of any format, as long as it gets them in the two-column format above.

What does this mean? If you're working with a set of gzipped tarballs, for instance, you don't have to actually decompress them first: you can just script a program that writes to `stdout` in the above format, and pass that program to the makefile. So if you wrote a script that printed out elements on the fly and put it into 'scripts' (the recommended, but not necessary, place) you could run

```{sh}
make bookwormName=OL textStream=scripts/unzipTarball.sh
```

and the bookworm would successfully build without any file named `input.txt` at all.

The lack of an `input.txt` may be a problem for certain extensions.

### Preprocessing

Lots of texts are messy: they have Google bookplates, hyphenated words broken at newlines, or scraps of HTML. You can leave these in the Bookworm and suffer through: or you can script around them, before writing to the input.txt or the textStream you'll be using. If you write useful code (for joining line-end breaks while removing newlines, for example, you could helpfully share it as a possible replacement for the textStream program that Bookworm uses.



## Note on the old format.
Previous versions of bookworm required as input a single file for each document stored. That was tremendously inefficient, so later versions are geared around formats that allow the use of one or a few input files.

It is still possible, though, to create a folder in files/texts/raw: the bookworm will automatically import each of the files in turn.
