import sys
import random
import scraper

if __name__ == "__main__":
	query = 'Van Gogh paintings'
	assert(scraper.format_query(query) == 'Van+Gogh+paintings')

	results = scraper.scrape_google_image_carousel(scraper.format_query(query))
	result = random.choice(results)

	assert(
		'name' in result
		and 'link' in result
		and 'image' in result
		and 'extensions' in result
	)

	assert(type(result['name']) is str)
	assert(type(result['link']) is str)
	assert(type(result['extensions']) is list)
	assert(type(result['image']) is str or result['image'] is None)


##


	query = 'Tom Hardy'
	assert(scraper.format_query(query) == 'Tom+Hardy')

	results = scraper.scrape_google_image_carousel(scraper.format_query(query))
	result = random.choice(results)
	
	assert(
		'name' in result
		and 'link' in result
		and 'image' in result
		and 'extensions' in result
	)

	assert(type(result['name']) is str)
	assert(type(result['link']) is str)
	assert(type(result['extensions']) is list)
	assert(type(result['image']) is str or result['image'] is None)


##


	query = 'Movies 2020'
	assert(scraper.format_query(query) == 'Movies+2020')

	results = scraper.scrape_google_image_carousel(scraper.format_query(query))
	result = random.choice(results)
	
	assert(
		'name' in result
		and 'link' in result
		and 'image' in result
		and 'extensions' in result
	)

	assert(type(result['name']) is str)
	assert(type(result['link']) is str)
	assert(type(result['extensions']) is list)
	assert(type(result['image']) is str or result['image'] is None)
