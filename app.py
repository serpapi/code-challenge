from loguru import logger
from parser_class import CarouselParser
"""
Script runs Parser Class which generates json file and list/array of elements
from image carousel in Google search engine results.

@author: katarzynski
"""


if __name__ == '__main__':
    logger.info('Starting extractor script');
    parser = CarouselParser(filePath='./files/van-gogh-paintings.html')
    parser.run()
