import json
import sys

from challenge import scrape

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Filename of HTML to parse required.', file=sys.stderr)
        sys.exit(1)

    json_result = scrape.scrape_art(sys.argv[1])
    print(json.dumps(json_result, indent=True, ensure_ascii=False))