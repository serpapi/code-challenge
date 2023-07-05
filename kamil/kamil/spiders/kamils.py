import scrapy
import json

    # Class set by default by scrapy
class KamilsSpider(scrapy.Spider):
     # Spider's name
    name = "kamils"
    # Spider's domain, in this case not neccessary because we use the html file
    allowed_domains = ["kamil.com"]
    # The first url we call, but it's just random in our case
    start_urls = ["http://kamil.com/"]

     # Start_requests is a default function supported by scrapy
    def start_requests(self):
        # Sends request to google, when it's done calls function callback named extractResponseData
        # In case of error calls function errback_httpbin
        yield scrapy.Request("https://google.com", callback=self.extractResponseData,
                                errback=self.errback_httpbin,
                                dont_filter=True)
    
    def extractResponseData(self, response):
        # Reads html file in the same directory and assigns to variable f 
        with open(r"C:\Kamil\kamil\kamil\van-gogh-paintings.html", "r", encoding='utf-8') as f:
            # Creates the variable response. Assigns f.read, it's whole html's content file 
            response = f.read()
            # Converts the whole html file and casts it to Selector scrapy. With Selector, we can use xpath function and extract the data 
            selector = scrapy.Selector(text=response, type="html")

            # /g-scrolling-carousel, we don't define the index and use extract method. Extract gets all elements, extract_first gets only one
            nameSecondList = selector.xpath("/html/body/div[6]/div[3]/div[7]/div[1]/div/div/div[2]/div[2]/div/div/g-scrolling-carousel/div/div/div/a/div[2]/div[1]").extract()

            # Array to save json array 
            resultJson = []
            # Index starts with one in DOM tree, html 
            index = 1

             # Writes to file json, 'w' stands for write 
            with open("expected-array.json", "w") as outfile:
                # Loops through the list array, gets name of a picture from html 
                # nameSecondList is a list name of pictures 
                for nameSecond in nameSecondList: 
                    # Removes all html tags, gets only the name of a picture 
                    nameSecond = nameSecond.replace('<div class="kltat"><span>', "")
                    nameSecond = nameSecond.replace('</span><wbr><span>', "")
                    nameSecond = nameSecond.replace('</span><wbr></wbr></wbr></div>', "")
                    nameSecond = nameSecond.replace('</span><wbr></wbr></div>', "")

                    # Finds extension year by index, index with increment by one
                    # method text() used to get only the text inside a tag. Example <div>abc</div>, so text method will return abc, also /div[2]/text() with div two because year in second div 
                    extensionsXpath = "/html/body/div[6]/div[3]/div[7]/div[1]/div/div/div[2]/div[2]/div/div/g-scrolling-carousel/div/div/div[" + str(index) + "]/a/div[2]/div[2]/text()"
                    # Because we already defined index, so extract first is enough
                    extensions = selector.xpath(extensionsXpath).extract_first()

                    # The same for the link, but in the last ]/a/@href, @href to get the href content 
                    linkXpath = "/html/body/div[6]/div[3]/div[7]/div[1]/div/div/div[2]/div[2]/div/div/g-scrolling-carousel/div/div/div[" + str(index) + "]/a/@href"
                    link = selector.xpath(linkXpath).extract_first()

                    # For the image it is also the same, we just get /img/@src to get all the data in src tag 
                    imgXpath = "/html/body/div[6]/div[3]/div[7]/div[1]/div/div/div[2]/div[2]/div/div/g-scrolling-carousel/div/div/div[" + str(index) + "]/a/div[1]/div/g-img/img/@src"
                    img = selector.xpath(imgXpath).extract_first()
                    
                    # Defines object in json 
                    jsonObject = {
                        "name": nameSecond,
                        "extensions": [extensions],
                        "link": "https://www.google.com" + link,
                        "image": img
                    }
                    # Appends data into the array 
                    resultJson.append(jsonObject)
                    index += 1
                    
                # Serializing json
                json_object = json.dumps(resultJson, indent=4)
                # Writes json to the file 
                outfile.write(json_object)


    def errback_httpbin(self, failure):
        # Logs all failures
        self.logger.error(repr(failure))
