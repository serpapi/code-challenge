from google_carousel_scraper import GoogleCarouselScraper


if __name__ == '__main__':

    # create instance of class
    g = GoogleCarouselScraper()

    # initialize scraping
    g.extract("./../files/van-gogh-paintings.html", "./output/artworks_array.json")