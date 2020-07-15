import os
from parse import parse_html
from selenium import webdriver


def test(array):
    if not isinstance(array, list):
        return False, 'Given result is not an array'

    for a in array:
        if not all (key in a for key in ('name', 'link', 'image')):
            return False, 'Array doesn\'t contain all attributes'

    first = array[0]

    if first['name'] != 'The Starry Night':
        return False, 'First painting is not The Starry Night'

    if first['extensions'][0] != '1889':
        return False, 'First painting is not from 1889'

    return True, 'All tests passed'

if __name__ == "__main__":
    driver = webdriver.Chrome('/usr/bin/chromedriver')

    html_path = os.path.abspath('files/van-gogh-paintings.html')
    driver.get('file://' + html_path)

    array = parse_html(driver)
    passed, description = test(array)
    print(passed, ',', description)