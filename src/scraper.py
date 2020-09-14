import sys
import time
import pprint
from concurrent import futures as future

from selenium import webdriver
import selenium.common.exceptions as exceptions
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


MAX_THREADS = 16
MAX_WAIT_TIME = 10

TARGET_URL = "https://www.google.com/search?safe=off&q={query}"

NAME_TARGET_CLASS = 'kltat'
NAME_TARGET_XPATH = ".//div[@class={name}]"

EXTS_TARGET_CLASS = 'ellip klmeta'
EXTS_TARGET_XPATH = ".//div[@class={exts}]"

chrome_options = Options()
chrome_options.add_argument("--headless")


def extract_exts_from_image(els):
	try:
		exts_divs = els.find_elements_by_xpath(EXTS_TARGET_XPATH.format(exts=EXTS_TARGET_CLASS))
	except exceptions.NoSuchElementException:
		exts_divs = []

	exts = []
	for e in exts_divs:
		exts.append(e.text)

	return exts


def extract_name_from_image(el):
	try:
		name_div = el.find_element_by_xpath(NAME_TARGET_XPATH.format(name=NAME_TARGET_CLASS))
		spans = name_div.find_elements_by_tag_name("span")
	except exceptions.NoSuchElementException:
		spans = []

	text = []
	for s in spans:
		text.append(s.text)

	return ' '.join(text)


def extract_image_data(image_element):
	image_link = image_element.get_attribute("href")
	image_name = extract_name_from_image(image_element)
	image_exts = extract_exts_from_image(image_element)
	wait = WebDriverWait(image_element, MAX_WAIT_TIME)

	try:
		image_data = wait.until(EC.visibility_of_element_located((By.XPATH, ".//img"))).get_attribute("src")
	except exceptions.TimeoutException:
		image_data = None

	return {
		'name': image_name,
		'extensions': image_exts,
		'link': image_link,
		'image': image_data
	}


def scrape_google_image_carousel(query):
	images_data = []
	full_url = TARGET_URL.format(query=query)

	driver = webdriver.Chrome("./chromedriver", options=chrome_options)
	wait = WebDriverWait(driver, MAX_WAIT_TIME)

	try:
		driver.get(full_url)

		carousel = wait.until(EC.presence_of_element_located((By.TAG_NAME, "g-scrolling-carousel")))
		image_list = carousel.find_elements_by_tag_name("a")
		driver.execute_script("arguments[0].scrollIntoView();", image_list[-1])

		with future.ThreadPoolExecutor(MAX_THREADS) as executor:
			futures = [executor.submit(extract_image_data, i) for i in image_list]

		images_data = [f.result() for f in future.as_completed(futures)]
	
	except exceptions.ErrorInResponseException as e:
		print("Serverside error:", e)
	
	except exceptions.TimeoutException as e:
		print('Loading image carousel timed out:', e)
	
	finally:
		driver.close()
		driver.quit()

	return images_data


def format_query(query):
	return query.replace(' ', '+')


if __name__ == "__main__":
	if len(sys.argv) == 2:
		arg = sys.argv[1]
		query = format_query(arg)

		data = {}
		data["artworks"] = scrape_google_image_carousel(query)

		pp = pprint.PrettyPrinter()
		pp.pprint(data)

		print(len(data))

	else:
		print("usage: `python3 scraper.py <search expression>`")