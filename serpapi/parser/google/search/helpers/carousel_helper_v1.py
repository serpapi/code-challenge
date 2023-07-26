import urllib.parse

from bs4 import BeautifulSoup, Tag

from serpapi.exceptions import UnableToParseException
from serpapi.parser.google.search.common import bs4_get_img_src
from serpapi.parser.google.search.models import CarouselItem
from serpapi.parser.abstract import AbstractParserHelper


class GoogleSearchCarouselParserV1(AbstractParserHelper):
    BASE_URL = "https://google.com"

    def _parse(self, data) -> list[CarouselItem]:
        soup = BeautifulSoup(data, features="html.parser")

        gallery = soup.css.select("#appbar g-scrolling-carousel")
        if not gallery:
            raise UnableToParseException()

        items = gallery[0].find_all("a", class_="klitem")

        result = []
        for item in items:
            item_obj = CarouselItem()
            self._fill_item_name(item, item_obj)
            self._fill_item_extensions(item, item_obj)
            self._fill_item_link(item, item_obj)
            self._fill_item_image(item, item_obj)

            result.append(item_obj)
        return result

    def _fill_item_name(self, item: Tag, item_obj: CarouselItem):
        tag = item.find(class_="kltat")

        if tag is None:
            raise UnableToParseException()

        item_obj.name = tag.text

    def _fill_item_extensions(self, item: Tag, item_obj: CarouselItem):
        item_obj.extensions = [i.text for i in item.find_all(class_="klmeta")]

    def _fill_item_link(self, item: Tag, item_obj: CarouselItem):
        href = item.attrs.get("href")

        if not href:
            return None

        item_obj.link = urllib.parse.urljoin(self.BASE_URL, href)

    def _fill_item_image(self, item: Tag, item_obj: CarouselItem):
        img = item.find("img")

        if img is None:
            raise UnableToParseException()

        item_obj.image = bs4_get_img_src(img)
