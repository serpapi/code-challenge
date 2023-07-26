from serpapi.models import BaseItem


class CarouselItem(BaseItem):
    name = None
    extensions = None
    link = None
    image = None


class SearchPage(BaseItem):
    carousel_items: list[CarouselItem] = None
