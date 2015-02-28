'''
Output
'''

from htrc_features import FeatureReader
import csv
import os
import argparse
import json
import logging

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('path', nargs='+')
    args = parser.parse_args()
    fr = FeatureReader(args.path)
    for vol in fr:
        if not vol:
            logging.error("Empty file")
            continue
        try:
            jmeta = {}
            for attr in ['genre', 'title', 'year', 'oclc', 'language', 'pageCount' ]:
                if hasattr(vol, attr):
                    if attr == 'year':
                        jmeta['date'] = vol.year
                    else:
                        jmeta[attr] = getattr(vol, attr)
                else:
                    jmeta[attr] = [] if attr == 'genre' else ''
            jmeta['filename'] = vol.id
            if hasattr(vol, "handleUrl"):
                jmeta['searchstring'] = u"<a href=\"{0}\">{1}</a>".format(vol.handleUrl, vol.title)
            else:
                jmeta['searchstring'] = vol.title
            print json.dumps(jmeta)
        except Exception, e:
            logging.exception(e)

if __name__=='__main__':
    main()
