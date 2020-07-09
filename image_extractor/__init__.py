from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException


class Driver():

    def __enter__(self):
        self.driver = webdriver.Chrome()
        return self.driver

    def __exit__(self, *args, **kwargs):
        self.driver.quit()




def extract_images(filelame):
    with Driver() as driver:
        driver.get("file://%s" % filelame)
        divs = driver.find_elements_by_class_name('klitem-tr')
        carousel = [] 
        top_stories = []
        search_suggestions = []
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
            carousel.append(item)
        top_stories_containers = driver.find_elements_by_class_name('So9e7d')
        for c in top_stories_containers:
            try:
                img = c.find_element_by_tag_name('img')
            except NoSuchElementException:
                continue
            src = img.get_attribute('src')
            title = c.find_element_by_class_name('mRnBbe').text
            link = c.find_element_by_tag_name('a').get_attribute('href')
            top_stories.append({
                "image": src,
                "name": title,
                "link": link
            })
        suggestion_link = driver.find_element_by_link_text('People also search for')
        suggestion_containers = suggestion_link.find_elements_by_xpath('../../div[@class="AAXrR lfNb6b"]//div[@data-reltype="sideways"]')
        for c in suggestion_containers:
            src = c.find_element_by_tag_name('img').get_attribute('src')
            title = c.find_element_by_class_name('ellip').get_attribute('innerText')
            link = c.find_element_by_tag_name('a').get_attribute('href').replace('file://', 'https://www.google.com')  
            search_suggestions.append({
                "image": src,
                "name": title,
                "link": link
            })          
        return {
            "carousel": carousel,
            "top_stories": top_stories,
            "search_suggestions": search_suggestions
        }

    