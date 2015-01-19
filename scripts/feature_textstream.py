'''
Write text stream in the form asked by bookworm. Note that there is no positional information, so the order is random.
This makes >1 grams meaningless in Bookworm, but still a good indicator of size and performance.
'''

from htrc_features import FeatureReader
import csv
import os
import glob

def main():
    path = os.path.join(os.getcwd(), 'book-sample', 'books', '*.json.bz2')
    volPaths = glob.glob(path)
    fr = FeatureReader(volPaths)
    for vol in fr:
        all_terms = [[t] * f for t,f in vol.term_volume_freqs(case=True).iteritems()]
        print "%s\t%s" %  (vol.id, " ".join(reduce(lambda x,y: x+y, all_terms)[1:10]) )

if __name__=='__main__':
    main()
