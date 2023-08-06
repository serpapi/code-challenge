from loguru import logger
from parser_class import CarouselParser


def testStringType(data) -> bool:
    logger.success("parsed data is string type")    
    if isinstance(data, str):
        return True

    logger.error("parsed data is not string type")    

def testListType(data) -> bool:
    if isinstance(data, list):
        logger.success("parsed data is list type")
        return True
    logger.error("parsed data is not list type")    

def testDictType(data) -> bool:
    if isinstance(data, dict):
        logger.success("parsed data is dict type")
        return True
    logger.error("parsed data is not dict type")    


if __name__ == '__main__':
    logger.info('Starting tests');
    parser = CarouselParser(filePath='./files/van-gogh-paintings.html', verbose=True)
    parsed_data = parser.run()
    
    testDictType(parsed_data)

    for pd in parsed_data['artworks']:
        testDictType(pd)
        if pd['name']: testStringType(pd['name']) 
        if pd['link']: testStringType(pd['link']) 
        if 'extensions' in pd: testListType(pd['extensions']) 
        if 'image' in pd: testStringType(pd['image'])