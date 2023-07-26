from abc import ABC


class BaseItem(ABC):

    def normalize(self) -> dict:
        return self.__dict__
