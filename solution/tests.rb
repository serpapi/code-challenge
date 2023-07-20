require 'rspec'
require 'uri'
require_relative './constants'
require_relative './scraper'
require_relative './util'

describe 'Google Search Scrape Demo:' do
  before :all do
    page_path = File.join(Dir.pwd, '/test_data', 'page.html')
    page_url = URI::File.build([nil, page_path])
    @doc = Scraper.nokodoc_via_selenium(url: page_url)

    page_path = File.join(Dir.pwd, '/test_data', 'other_page.html')
    page_url = URI::File.build([nil, page_path])
    @bad_doc = Scraper.nokodoc_via_selenium(url: page_url)

    @carousel = Scraper.extract_carousel(noko_html_doc: @doc)
    @item_xml_eles = Scraper.extract_carousel_items(carousel_xml_ele: @carousel)
  end

  describe 'get html document' do
    it 'starts with an html document' do
      expect(@doc).to be_instance_of(Nokogiri::HTML4::Document)
      expect(@doc.text.length).to be > 0
    end
  end

  describe 'generic css class search' do
    it 'finds all descendents which have a given css class' do
      results = Scraper.extract_decendants_with_class(noko_xml_ele: @doc,
                                                      css_class: 'klitem')
      expect(results.count).to be(3)

      results = Scraper.extract_decendants_with_class(noko_xml_ele: @doc,
                                                      css_class: 'barbie')
      expect(results.count).to be(1)
    end

    it 'does not find any descendents when none have a given css class' do
      results = Scraper.extract_decendants_with_class(noko_xml_ele: @doc,
                                                      css_class: 'nosuchclass')
      expect(results.count).to be(0)
    end
  end

  describe 'carousel within the html doc' do
    it 'finds the carousel section' do
      expect(@carousel).to be_instance_of(Nokogiri::XML::Element)
      expect(@carousel.text.length).to be > 0
    end

    it 'does not find a carousel where one does not exist' do
      expect(Scraper.extract_carousel(noko_html_doc: @bad_doc)).to be nil
    end
  end

  describe 'carousel item scraping' do
    it 'finds items within the carousel' do
      expect(@item_xml_eles.count).to be > 0
      expect(@item_xml_eles.all? { |x| x['class'].include?('klitem') })
    end

    it 'finds the link in a carousel item' do
      expect(@item_xml_eles.map { |x| Scraper.extract_item_href(noko_xml_ele: x).start_with?(Constants::GOOGLE_BASE_URL + '/search') }).to all(be true)
    end

    it 'finds the title in a carousel item' do
      expect(@item_xml_eles.count).to eq(3)

      items_with_title = @item_xml_eles[0...1] # We know this because we know the test html file.

      expect(items_with_title.map { |x| Scraper.extract_item_title(noko_xml_ele: x).length }).to all(be > 0)

      # Demonstrate finding the exact title we know is there.
      expect(Scraper.extract_item_title(noko_xml_ele: items_with_title.first)).to eq('Some Title example 1')
    end

    it 'gets an empty string if no title is found' do
      item_without_title = @item_xml_eles[2]   # Third item is missing the title div in text file.

      # The third is missing the title div. Expect a clean (but empty string) result.
      expect(Scraper.extract_item_title(noko_xml_ele: item_without_title)).to eq('')
    end

    it 'gets the image source' do
      # items 1 and 3 have an img src, but item 2 has a blank src (intentionally)
      expect(Scraper.extract_item_img_src(noko_xml_ele: @item_xml_eles[0]).length).to be > 0
      expect(Scraper.extract_item_img_src(noko_xml_ele: @item_xml_eles[2]).length).to be > 0
    end

    it 'gets an empty string if image source is empty' do
      # item 2 has an empty img src
      expect(Scraper.extract_item_img_src(noko_xml_ele: @item_xml_eles[1]).length).to be(0)
    end

    it 'gets the year of the carousel item' do
      # The div containing the year has multiple css classes in some cases, but
      #   the required class (klmeta) must be in the list for us to find the year.
      years = %w[2001 2002 2003]
      expect(@item_xml_eles.map { |x| Scraper.extract_item_year(noko_xml_ele: x) }).to eq(years)
    end
  end


end
