from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import json

chrome_options = Options()
chrome_options.add_argument("--headless")


driver = webdriver.Chrome('C:/Users/Hosel/Downloads/chromedriver_win32/chromedriver.exe', options=chrome_options)
driver.get('C:/Users/Hosel/OneDrive/Documents/Web-Dev/code-challenge/files/van-gogh-paintings.html')

# Test on Different Search Queries
# driver.get('https://www.google.com/search?q=Famous+Boxers&oq=Famous+Boxers&aqs=chrome..69i57.1463j0j1&sourceid=chrome&ie=UTF-8')
# driver.get("https://www.google.com/search?q=Famous+Basketball+Players&ei=AvEaYZeTDNu5tAadubOgCw&oq=Famous+Basketball+Players&gs_lcp=Cgdnd3Mtd2l6EAMyCAgAEIAEELEDMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEOhQIABDqAhC0AhCKAxC3AxDUAxDlAjoUCC4Q6gIQtAIQigMQtwMQ1AMQ5QI6BwguEEMQkwI6BAgAEEM6CwgAEIAEELEDEIMBOgQILhBDOg4ILhCABBCxAxDHARCjAjoNCC4QxwEQrwEQQxCTAjoKCAAQsQMQgwEQQzoFCAAQkQI6BwgAELEDEEM6CgguEMcBEK8BEEM6EQguEIAEELEDEIMBEMcBEKMCOggIABCABBDJAzoFCAAQkgM6CAgAEMkDEJECOggIABCxAxCDAToOCC4QgAQQsQMQxwEQrwFKBAhBGABQyBlYqDRgszVoAXACeACAAcMBiAGAF5IBBDguMTiYAQCgAQGwAQrAAQE&sclient=gws-wiz&ved=0ahUKEwiXnP-_1bbyAhXbHM0KHZ3cDLQQ4dUDCA4&uact=5")
# driver.get('https://www.google.com/search?q=New+York+Knicks+players&oq=New+York+Knicks+players&aqs=chrome..69i57.6881j0j1&sourceid=chrome&ie=UTF-8')
# driver.get('https://www.google.com/search?q=Famous+plays&ei=w_IaYdDDEsyMtAbd2YSoAg&oq=Famous+plays&gs_lcp=Cgdnd3Mtd2l6EAMyCwgAEIAEELEDEIMBMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEMgUIABCABDIFCAAQgAQyBQgAEIAEOhQILhCABBCxAxCDARDHARCjAhCTAjoECAAQQzoICAAQgAQQyQM6BQgAEJIDOgUIABCRAjoICAAQgAQQsQM6BQgAELEDOgsILhCABBDHARCvAToLCAAQgAQQsQMQyQNKBAhBGABQ6BhYyypgxitoAHACeACAAZ0CiAGzB5IBBTEuNS4xmAEAoAEBwAEB&sclient=gws-wiz&ved=0ahUKEwiQsZKW17byAhVMBs0KHd0sASUQ4dUDCA4&uact=5')
# driver.get('https://www.google.com/search?q=Trier&stick=H4sIAAAAAAAAAEWSO4sTURSAM6N53c1CMqsiqXYj4hpc5pHHTGziAwthg5CNxVYhc-9kMpnnzgxJZkor7cQinSxYqIi_wMKIiGAKC4WUEtxKm7USEWE3j3tj9517z_nOuY9ENJdgTZYTVdQXUnXbbFmbUPM1xRtTi41yQehg5A84A2Ox6xAUHMkdU-usyvK8DEsSpyNSO5dirJSd8phKLjRlUepiFny_OBOBBZdcRwxxUHKQpFdwsc73OIxtV7AIdrwQaypdnzeI3ipaCHNBhl6brFdKFbRq5XHeAZmSly0yTm8AZ874nJt9FScgx1VJodjUEcku8P2Bu5KEMkZVDBAZkXdJgiyYEKMTwh7xSRxE4f8LCOYWHPgw5FZpRVMKcNuS0PTIAaGkG_pqtrCnq9-pF_Ra-sefbxvZp_ST158m1JAG6V3b9hQjqCtGy1dQw2augdgdy9f8gEllAVi-NDQd4RxYvqRe1mEHSU76cDqkGATW9hS_YddspLUD5j6zB5I1xZQV17vXZgoA3LYNQ4G-ZlvM5ewlsMXC1QK7_E47vt23vJ2eZhgtVfFy6_Xln7IKwjuKvk5v0zlLaL75Mvwc289kX52c3PxVu5G9mmdA_K63a8OWkZEHHw6PrKNqfgMkGq2BbdlmkBEfXZg-_HdczW0lK7euRCbnn1cz-_Tv0cfjn6OLZzYj2xH-6yQ-jTX_jvKRWacHb1--j51NUOlI6lk02nA1xX0co04BVDdcQgcDAAA&sa=X')

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

	with open('expected-json.json', 'w') as file:
		jsonstuff = json.dumps(total, indent=4)
		file.write(""" "artworks": """)
		file.write(jsonstuff)

driver.quit()