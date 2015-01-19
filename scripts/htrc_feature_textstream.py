'''
Write text stream in the form asked by bookworm. Note that there is no positional information, so the order is random.
This makes >1 grams meaningless in Bookworm, but still a good indicator of size and performance.
'''

from htrc_features import FeatureReader
import csv
import os
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('path', nargs='+')
    args = parser.parse_args()
    fr = FeatureReader(args.path)
    for vol in fr:
        all_terms = [[t] * f for t,f in vol.term_volume_freqs(case=True).iteritems()]
        print ("%s\t%s" %  (vol.id, " ".join(reduce(lambda x,y: x+y, all_terms)) )).encode('UTF-8')

if __name__=='__main__':
    main()
