# Not specifically needed for this test/excercise,
# but is an example on how we can make the scrapping agnostic and be able to use any search(PageSearch) in combination with any extractor(Google extractors, Yahoo Extractors, etc, etc.)
class Scrap
  def initialize(search, extractor)
    @search = search
    @extractor = extractor
  end

  def process
    @extractor.new(@search).extract
  end
end
