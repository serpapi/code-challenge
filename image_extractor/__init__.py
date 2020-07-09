from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException


class Driver():

    def __enter__(self):
        options = webdriver.ChromeOptions()
        options.add_argument('--ignore-certificate-errors')
        options.add_argument('--headless')
        options.add_argument("--start-maximized") 
        options.add_argument("--disable-infobars")
        options.add_argument("--disable-extensions")
        options.add_argument("--disable-gpu")
        options.add_argument("--disable-dev-shm-usage")
        options.add_argument("--no-sandbox")
        self.driver = webdriver.Chrome(options=options)
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
        sidebar_images = []
        for d in divs:
            src = d.find_element_by_tag_name('img').get_attribute('src')
            name = d.find_element_by_class_name('kltat').text
            try:
                link = d.find_element_by_tag_name('a').get_attribute('href').replace('file://', 'https://www.google.com')
            except NoSuchElementException:
                link = d.find_element_by_xpath('../a').get_attribute('href').replace('file://', 'https://www.google.com')
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
        suggestion_containers = driver.find_elements_by_xpath('//div[@data-reltype="sideways"]')
        for c in suggestion_containers:
            src = c.find_element_by_tag_name('img').get_attribute('src')
            if src == 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==':
                continue
            title = c.find_element_by_class_name('ellip').get_attribute('innerText')
            link = c.find_element_by_tag_name('a').get_attribute('href').replace('file://', 'https://www.google.com')  
            search_suggestions.append({
                "image": src,
                "name": title,
                "link": link
            })   
        sidebar_img_containers = driver.find_elements_by_xpath('//div[contains(@class, "eA0Zlc ivg-i PtaMgb")]')
        for c in sidebar_img_containers:
            img = c.find_element_by_tag_name('img')
            sidebar_images.append({
                "image": img.get_attribute('src'),
                'link': img.get_attribute('title')
            })
        return {
            "carousel": carousel,
            "top_stories": top_stories,
            "search_suggestions": search_suggestions,
            "sidebar_images": sidebar_images
        }

    