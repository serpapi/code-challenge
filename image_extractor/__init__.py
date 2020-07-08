from bs4 import BeautifulSoup
from selenium import webdriver



def extract_images(filelame):
    driver = webdriver.Chrome()
    driver.get("file://%s" % filelame)
    