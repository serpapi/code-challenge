# Parse directly the HTML result page (html file) in this repository. No extra HTTP requests should be needed for anything.
# Add also to your array the painting thumbnails present in the result page file (not the ones where extra requests are needed).
# Test against 2 other similar result pages to make sure it works against different layouts. (Pages that contain the same kind of carrousel. Don't necessarily have to be paintings.)

from selenium import webdriver
from selenium.webdriver.common.by import By
import json, requests

url = 'http://www.google.com/search?q=gustav+klimt+paintings'

#classes found by inspecting elements in google
# name = 'pgNMRc'
# img = 'taFZJe'
# link = 'iELo6'
# year = 'cxzHyb'

driver = webdriver.Chrome()
driver.get(url)

#expand to view more of the carousel
expand = driver.find_element(By.CSS_SELECTOR, '.s9Fv6b')
expand.click()

#parse HTML code
html_file =driver.page_source
html_file_text = str(html_file)
with open('raw_file.html', 'w', encoding="utf-8") as html:
    html.write(html_file_text)

def get_text_from_elements(class_name):
    elements = driver.find_elements(By.CLASS_NAME, class_name)
    return [element.text for element in elements]

def get_src_from_elements(class_name):
    elements = driver.find_elements(By.CLASS_NAME, class_name)
    return [element.get_attribute('src') for element in elements]

#save JSON data to a file

def extract_data():
    name = driver.find_elements(By.CLASS_NAME, 'pgNMRc')
    img = driver.find_elements(By.CLASS_NAME, 'taFZJe')
    link = driver.find_elements(By.CLASS_NAME, 'iELo6')
    year = driver.find_elements(By.CLASS_NAME, 'cxzHyb')

    data_list = []
    for name, img, link, year in zip(name, img, link, year):
        data = {
            'name': name.text,
            'img': img.get_attribute('src'),
            'link': link.get_attribute('href'),
            'year': [year.text]
        }
        data_list.append(data)
    return data_list

data_array = extract_data()
json_string = json.dumps(data_array, indent=2, ensure_ascii=False)

with open('data.json', 'w', encoding='utf-8') as json_file:
    json_file.write(json_string)

driver.quit()