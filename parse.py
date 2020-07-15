from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By


def parse_html(driver):
    carrousel = driver.find_element(
        By.XPATH, '//*[@id="_c2yRXMvVOs3N-QazgILgAg93"]/div/div')
    paintings = carrousel.find_elements_by_class_name("klitem")

    array = []
    for p in paintings:
        # get title
        title = p.get_attribute('aria-label')

        # get link
        link = p.get_attribute('href')
        link = link.replace('file://', 'https://www.google.com', 1)

        # get image
        img_box = p.find_element_by_class_name('BA0A6c')
        img = img_box.find_element_by_tag_name('img')
        src = img.get_attribute('src')

        # get date
        try:
            date = p.find_element_by_class_name('klmeta').text
        except:
            date = ''

        result = {
            "name": title,
            "extensions": [date],
            "link": link,
            "image": src
        }

        if date is '':
            result.pop('extensions')

        array.append(result)
    return array


if __name__ == "__main__":
    driver = webdriver.Chrome('/usr/bin/chromedriver')
    
    html_path = os.path.abspath('files/van-gogh-paintings.html')
    driver.get('file://' + html_path)

    array = parse_html(driver)
    print(array)
