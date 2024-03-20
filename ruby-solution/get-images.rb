require 'nokogiri'
require 'selenium-webdriver'
require 'json'

def writeJsonObjToFile(jsonObj)
    jsonFile = File.open("./data.json", "w")
    jsonFile.write(JSON.pretty_generate(jsonObj))
    jsonFile.close()
end

def initializeSelenium(filename)
    options = Selenium::WebDriver::Firefox::Options.new
    options.add_argument('--headless')
    driver = Selenium::WebDriver.for :firefox, options: options 

    driver.navigate.to filename

    return driver
end

def run()
    # need to change value of string to absolute file path below of html file
    # corresponding html file and assets i.e. brandon_sanderson_books_in_order_files

    filename = '<absolute-file-path>' 
    driver = initializeSelenium(filename)

    doc = Nokogiri::HTML(driver.page_source)

    # get all a tags from carousel    
    aTags = doc.css('g-scrolling-carousel')[0].css('a')
        # loop through all a tags
    
    artworksArr = []

    aTags.each do |aTag|
        title = aTag.attribute('aria-label').value
        link  = aTag.attribute('href').value
        tagTitle = aTag.attribute('title').value
        itemDate = tagTitle[tagTitle.length - 5..-1]     
        img = aTag.css('img')
       
        # check if image contains source field to include 
        imgHtml = img.to_html
        
        # create json obj       
        jsonObj = {
            'name' => title
        }

        # check if date exists
        if(itemDate =~ /\d/)
            jsonObj['extensions'] = [itemDate.chop]
        end

        jsonObj['link'] = link
        
        # check if img src exists
        if(img.attribute('src'))
            # set json value here        
            jsonObj['image'] = img.attribute('src').value

        end
        artworksArr.append(jsonObj)
    
        
    
    end

    # create outer json obj
    artworksJson = {
        'artworks' => artworksArr
    }
    
    writeJsonObjToFile(artworksJson)
end

run
