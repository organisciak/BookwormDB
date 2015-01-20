'''
Output
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
        json = {}
        for attr in ['genre', 'title', 'year', 'oclc', 'language', 'pageCount', 'imprint' ]:
            if hasattr(vol, attr):
                json[attr] = getattr(vol, attr)
            else:
                json[attr] = [] if attr == 'genre' else ''
        json['filename'] = vol.id
        if hasattr(vol, "handleUrl"):
            json['searchstring'] = "<a href=\"{}\">{}</a>".format(vol.handleUrl, vol.title)
        else:
            json['searchstring'] = vol.title
        print json

if __name__=='__main__':
    main()
