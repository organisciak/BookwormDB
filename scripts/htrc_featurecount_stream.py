'''
Write token counts in the form "id   unigram   count" per volume in the HTRC feature extraction dataset.
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
        for term, count in vol.term_volume_freqs(case=True).iteritems():
            print "%s\t%s\t%i" % (vol.id.encode('utf-8'), term.encode('utf-8'), count)

if __name__=='__main__':
    main()
