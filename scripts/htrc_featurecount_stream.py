'''
Write token counts in the form "id   unigram   count" per volume in the HTRC feature extraction dataset.
'''

from htrc_features import FeatureReader
import csv
import os
import argparse
import logging

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('path', nargs='+')
    args = parser.parse_args()
    fr = FeatureReader(args.path)
    for vol in fr:
        if not vol:
            print "Empty file"
            continue
        try:
            for term, count in vol.term_volume_freqs(case=True).iteritems():
                print "%s\t%s\t%i" % (vol.id.encode('utf-8'), term.encode('utf-8'), count)
        except Exception, e:
            logging.exception(e)


if __name__=='__main__':
    main()
