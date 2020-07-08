from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException



def extract_images(filelame):
    driver = webdriver.Chrome()
    driver.get("file://%s" % filelame)
    divs = driver.find_elements_by_class_name('klitem-tr')
    result = [] 
    for d in divs:
        src = d.find_element_by_tag_name('img').get_attribute('src')
        name = d.find_element_by_class_name('kltat').text
        link = d.find_element_by_tag_name('a').get_attribute('href').replace('file://', 'https://www.google.com')
        try:
            extensions = d.find_element_by_class_name('klmeta').text
        except NoSuchElementException:
            extensions = None
        item = {
            "name": name,
            "link": link,
            "image": src
        }
        if extensions:
            item['extensions'] = [extensions]
        result.append(item)
    return result

    