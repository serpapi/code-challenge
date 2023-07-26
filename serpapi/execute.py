import argparse
import json
from typing import Iterable

from serpapi.models import BaseItem
from serpapi.parser.google.search.models import CarouselItem
from serpapi.parser.google.search.parser import GoogleSearchParser


def extract_carousel_items(src_path) -> list[CarouselItem]:
    with open(src_path, "r") as f:
        data = f.read()

    return GoogleSearchParser(data).parse().carousel_items


def serialize(items: Iterable[BaseItem]) -> str:
    if items is None:
        data = None
    else:
        data = [i.normalize() for i in items]

    return json.dumps({"artwork": data}, indent=2)


def output(data):
    print(data)


def cli(args=None):
    parser = argparse.ArgumentParser(
        description='Extract art images from Google Search HTML page.')
    parser.add_argument('-s',
                        '--src-path',
                        dest='src_path',
                        type=str,
                        required=True)
    args = parser.parse_args(args)

    src_path = args.src_path

    entities = extract_carousel_items(src_path)
    data = serialize(entities)
    output(data)
