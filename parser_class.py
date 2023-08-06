from bs4 import BeautifulSoup
from loguru import logger
import pprint
import json

pp = pprint.PrettyPrinter(indent=4)


class CarouselParser:

    _verboseEnabled = True
    _filePath = None
    
    @logger.catch
    def __init__(self, verbose = True, filePath = None) -> None:
        """
        Initializing class wide configuration and variables
        """
        self._verboseEnabled = verbose

        if filePath is None:
            self.__verbose_print("File path is not set", "error")
            exit(1)

        self._filePath = filePath
        pass

    @logger.catch
    def __verbose_print(self, string, type="info") -> None:
        """
        Print out text info regarding process status
        """
        if self._verboseEnabled:
            if type == "error":
                logger.error(string)
            elif type == "success":
                logger.success(string)
            else:
                logger.info(str(string))

    @logger.catch
    def retrive_carousel(self) -> BeautifulSoup:
        with open(self._filePath) as fp:
            soup = BeautifulSoup(fp, 'html.parser')
        
        return soup.find('g-scrolling-carousel')

    @logger.catch
    def run(self) -> list:
        self.__verbose_print("Retrieving carousel object")
        extractedList = []
        carouselHtml = self.retrive_carousel()
        carouselDivList = carouselHtml.find_all_next('div')[1]
        """
        Note:
        I decided to iterate over divs than attributes like classes or ID's 
        because latter are variable and may be changed with next page parsing (in non-static scenario).
        """
        totalNumberOfElements = len(list(carouselDivList.children))
        self.__verbose_print("Found " + str(totalNumberOfElements) + " elements")

        for child in carouselDivList.children:
            extractedList.append({
                'name': self.get_child_text(child),
                'link': self.get_child_link(child),
                'extensions': self.get_child_extensions(child),
                'image': self.get_child_image_src(child)
            })

        self.__verbose_print("Finished scraping " + str(totalNumberOfElements) + " elements")
        self.__verbose_print("Building json file")
        purifiedExtractedList = self.purifyData(extractedList)
        self.create_json(purifiedExtractedList)

        return purifiedExtractedList

    @logger.catch    
    def get_child_text(self, html_tag) -> str:
        divs = html_tag.find_all('div')[:-1][2].div.text
        if divs:
            return str(divs)
        else:
            return ""

    @logger.catch    
    def get_child_extensions(self, html_tag) -> list:
        divs = html_tag.find_all('div')[:-1][2]
        childDivs = divs.find_all('div')
        resultList = []

        if len(childDivs) > 1:
            for i,v in enumerate(childDivs):
                if i > 0:
                   resultList.append(v.text)

        return resultList
        

    @logger.catch    
    def get_child_link(self, html_tag) -> str:
        return str(html_tag.a.get('href'))

    @logger.catch
    def get_child_image_src(self, html_tag) -> str:
        gimg = html_tag.find('g-img').img
        if str(gimg.get('data-key')):
            return str(gimg.get('data-key'))
        
        return None
    
    @logger.catch  
    def create_json(self,list) -> None:
        with open("results.json", "w") as outfile:
            json.dump(list, outfile, indent = 4)

    @logger.catch 
    def purifyData(self, data) -> dict:
        new_data = []
        for d in range(len(data)):
            new_data.append({k: v for k, v in data[d].items() if v != "None" and v})
        return {'artworks': new_data}