import logging
from abc import ABC, abstractmethod
from typing import Any

from serpapi.exceptions import UnableToParseException


class AbstractParserHelper(ABC):

    def parse(self, data: str) -> Any:
        """
        :raises UnableToParseException:
        """
        try:
            return self._parse(data)
        except UnableToParseException as e:
            raise e
        except Exception as e:
            logging.exception(e, extra={"data": data})
            raise e

    @abstractmethod
    def _parse(self, data: str) -> Any:
        """
        :raises UnableToParseException:
        """
        pass
