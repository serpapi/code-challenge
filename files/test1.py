# This is for Test term on Google: "Famous Boxers"

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import json

chrome_options = Options()
chrome_options.add_argument("--headless")


driver = webdriver.Chrome('C:/Users/Hosel/Downloads/chromedriver_win32/chromedriver.exe', options=chrome_options)

driver.get('https://www.google.com/search?q=Famous+Boxers&oq=Famous+Boxers&aqs=chrome..69i57.1463j0j1&sourceid=chrome&ie=UTF-8')

soup = BeautifulSoup(driver.page_source, 'html.parser')
# Main Div containing Data
x = soup.find("div", class_="EDblX DAVP1")
# print(x)
total = []
for i in x:
	if("MiPcId") in i.get('class'):
		totalext = []
		current = {}
		title = i.find('a').get('title')
		link = i.find('a').get('href')
		if '(' in title or ')' in title:
			name = title.split('(')[0]
			ext = title.split('(')[1].strip(')')
			totalext.append(ext)
		else: 
			name = title
			ext = 'null'

		if i.find('g-img') != None:
			img = i.find('g-img').find('img').get('src')
		else:
			img = 'No Img'

		current['name'] = name
		current['extensions'] = totalext
		current['link'] = "https://www.google.com/" + str(link)
		current['image'] = img

		total.append(current)

	else:
		# Current Format includes Extensions along with name
		totalext = []
		current = {}
		title = i.get('title')
		link = i.get('href')
		if i.find('g-img') != None:
			img = i.find('g-img').find('img').get('src')
		else:
			img = 'null'

		if '(' in title or ')' in title:
			name = title.split('(')[0]
			extension = title.split('(')[1].strip(')')
			totalext.append(extension)
		else:
			name = title
			extension = 'No extension'

		current['name'] = name
		current['extensions'] = totalext
		current['link'] = "https://www.google.com/" + str(link)
		current['image'] = img

		total.append(current)

	with open('Test1-Famous-Boxers.json', 'w') as file:
		jsonstuff = json.dumps(total, indent=4)
		file.write(""" "artworks": """)
		file.write(jsonstuff)

driver.quit()