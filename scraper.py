from bs4 import BeautifulSoup
from bs4.element import NavigableString
import re
import json
import os

import logging
logging.basicConfig(format='[%(asctime)s - %(filename)s:%(lineno)s - %(levelname)s] - %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

if __name__ == '__main__':
	files = os.listdir("./files")
	for f in files:
		if f.find("html") != -1 and f.find("json") == -1:
			soup = BeautifulSoup(open("./files/{}".format(f)),"html.parser")
			logger.info("Processed file - files/{}".format(f))
			parsedData = []
			text = open("files/van-gogh-paintings.html").read()
			images = re.findall(r'\'data:image/jpeg;base64,(.*?)\';', text)
			for carousel in soup.find_all("g-scrolling-carousel"):
				div = carousel.find_all("div", class_="EDblX DAVP1")[0]
				children = div.children
				for index,data in enumerate(div.children):
					try:
						if data.name == "div":
							aData = data.find_all("a")[0]
						else:
							aData = data
						d= {"name":aData["aria-label"], "link":"https://www.google.com" + aData['href']}
						if index < len(images) - 1:
							d["image"] = "data:image/jpeg;base64," + images[index]
						else:
							d["image"] = None
						parsedData.append(d)
						caption = ""
						for desc in aData.descendants:
							if type(desc) == NavigableString:
								caption += desc.strip() + " "
						caption = caption.strip().replace(d["name"],"")
						if caption != "":
							d["extensions"] = [caption.strip()]
					except KeyError as e:
						logger.debug("Error in processing - {}. Error - {}".format(data, e))
			outputFileName = f + ".json"
			json.dump({"artworks":parsedData}, open("./files/{}".format(outputFileName),'w'))
			logger.info("Processed. output saved in files/{}".format(outputFileName))