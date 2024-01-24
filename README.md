# Extracting Data from Google Search Results Carousel
### Created by Austen Ariniello for the SerpApi Code Challenge
Project specifically designed and tested with the provided "van-gogh-paintings.html" file

## To Run

Install the neccessary libraries using bundle
    
    bundle install

Once everything is installed, you can generate a JSON file of results using the following command
    
    ruby -r ./files/lib/van-gogh-paintings.rb -e van_gogh_carousel_scrape_JSON

The output from running this command will appear in a file titled "van-gogh-paintings.json". You can compare this output to the file titled "van-gogh-paintings-ariniello.json". The results in this file were generated before I submitting my project through GitHub.

I used RSpec to write my tests. To run the test file, you can move into the files directory:

    cd files

and you can use the following command to run the tests:

    bundle exec rspec

## My Strategy

Most of my thought process and strategy has been documented in "van-gogh-paintings.rb". However, I will provide a brief summary of my approach. My first step was to open the HTML file in Google Chrome and use the inspect tool to find the key elements of the carousel. I planned on using Nokogiri to help parse through the raw HTML and find the carousel elements through the use of CSS selectors. However, I noticed that the image's source links from the raw HTML file did not match the source links in the HTML file that was loaded on the web browser. After further inspecting the HTML code, I noticed that the image links were being manipulated by a JavaScript element. Therefore, I knew that I needed to run the HTML script in order to properly access this dynamically loaded content. To do this, I used Selenium Webdriver to create a headless browser to properly run the HTML script and access the correct image source links.

Unfortunately, I was not able to generate any other Google search results that contained carousel objects that were similar to the objects in the example file. Therefore, I was unable to test my code with any other similar result pages. Ideally, I would have liked to start off my project by finding three different examples of the carousel object. Using these examples, I would find differences and similarities in the HTML code so that I could write a program that would properly extract the key information from all similar carousel objects. Additionally, this would allow me to be more thorough with my testing approach.

For my initial approach to testing, I wanted to build tests that would be more applicable to general usage of this program. Therefore, I did not want to check against any hard values. For the first 17 tests, I ensure that the data being returned is of the correct type and in the expected format. I also ensure that the returned data converts into a JSON object without error. For the last couple of tests, I compared my results to more specific information in the expected results JSON file. I used a random number generator to select three random objects to compare results to. 
    
If I had more time and resources, I would have loved to make a more robust approach to both the extraction process and the testing portion of this project. However, I thoroughly enjoyed working on this project for your team, and I am thrilled by the prospect of joining your team. Thank you taking the time to look at my code, and for giving me this exciting opportunity.
