#!/usr/bin/env python3

import sys
import json
import os

import image_extractor

def main():
    try:
        filename = sys.argv[1]
    except IndexError:
        print('Please provide filename to parse', file=sys.stderr)
        sys.exit(1)
    if not os.path.exists(filename) or not os.path.isfile(filename):
        print('Fie does not exist', file=sys.stderr)
        sys.exit(1)
    result = image_extractor.extract_images(filename)
    print(json.dumps(result))


if __name__ == "__main__":
    main()