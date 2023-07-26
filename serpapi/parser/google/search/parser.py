from serpapi.exceptions import UnableToParseException
from serpapi.parser.google.search.helpers.carousel_helper_v1 import GoogleSearchCarouselParserV1
from serpapi.parser.google.search.helpers.carousel_helper_v2 import GoogleSearchCarouselParserV2
from serpapi.parser.google.search.models import CarouselItem, SearchPage
from serpapi.parser.abstract import AbstractParserHelper


class GoogleSearchParser:
    BASE_URL = "https://google.com"

    def __init__(self, data):
        self._data = data
        self._carousel_parser_helpers = [
            GoogleSearchCarouselParserV1(),
            GoogleSearchCarouselParserV2(),
        ]

    def parse(self) -> SearchPage:
        entity = SearchPage()
        self._fill_carousel_items(entity)

        return entity

    def _fill_carousel_items(self, entity: SearchPage):
        entity.carousel_items = self._iterate_parser_helpers(
            self._carousel_parser_helpers)

    def _iterate_parser_helpers(
            self, helpers: list[AbstractParserHelper]) -> list[CarouselItem]:
        for i in helpers:
            try:
                return i.parse(self._data)
            except UnableToParseException:
                pass
