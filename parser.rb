# frozen_string_literal: true

require 'json'
require 'nokogiri'

# Parser parses Google search result HTML files and extracts the data for
# the artworks gallery that is visible on top of the search results.
#
# It produces a JSON array of objects for each
# of the artworks, e.g.
# [
#   {
#      "name": <name of the image>,
#      "extensions":[
#         <search extensions>
#      ],
#      "link": <link to the search for that image>,
#      "image": <base64 encoded image>
#   },
#   ...
# ]
class Parser
  # set constants
  GOOGLE_IMAGE_ARTWORK_CLASS = '.klitem-tr'
  GOOGLE_IMAGE_LINK_CLASS = '.klitem'
  GOOGLE_IMAGE_NAME_CLASS = '.kltat'
  GOOGLE_IMAGE_ID_CLASS = '.rISBZc'
  GOOGLE_IMAGE_EXTENSIONS_CLASS = '.klmeta'
  GOOGLE_BASE64_IMAGE_IDENTIFIER = 'kximg'
  GOOGLE_SET_IMAGE_SRC_FUNCTION = 'function _setImagesSrc(e, c)'
  GOOGLE_SET_INDIVIDUAL_IMAGE_SRC_FUNCTION = '_setImagesSrc(ii, s)'
  GOOGLE_HOST = 'https://www.google.com'

  # initialize an instance of the Parser class with the file to be parsed
  def initialize(file_path)
    @nokogiri_doc = Nokogiri::HTML(File.open(file_path))
  end

  # extract_artworks parses the given HTML file and assembles and
  # returns the artworks JSON
  def extract_artworks
    # initiate empty array that will contain image objects
    results = []

    # in the source HTML file the image source is not the actual encoded
    # image but a placeholder so we need to get the actual values
    base64_images = extract_base64_images(@nokogiri_doc)

    # iterate over artwork elements and extract the required data for each
    @nokogiri_doc.css(GOOGLE_IMAGE_ARTWORK_CLASS).each do |el|
      # initialize object that will hold the image data
      obj = {}

      # extract the name
      obj['name'] = el.css(GOOGLE_IMAGE_NAME_CLASS).text

      # assemble extensions (if there are any)
      if el.css(GOOGLE_IMAGE_EXTENSIONS_CLASS).children.any?
        extensions = []
        el.css(GOOGLE_IMAGE_EXTENSIONS_CLASS).children.each do |child|
          extensions.push(child.to_s)
        end
        obj['extensions'] = extensions
      end

      # extract the search link
      # consider different HTML structure of van-gogh-paintings.html
      # and newer monet-paintings.html
      if el.attribute('href')&.value
        obj['link'] = el.attribute('href').value
      else
        obj['link'] = GOOGLE_HOST + el.css(GOOGLE_IMAGE_LINK_CLASS).attribute('href').value
      end

      # consider different HTML structure of van-gogh-paintings.html
      # and newer monet-paintings.html
      if el.css(GOOGLE_IMAGE_ID_CLASS).attribute('src') &&
         el.css(GOOGLE_IMAGE_ID_CLASS).attribute('src').text.include?('data:image/jpeg')
        obj['image'] = el.css(GOOGLE_IMAGE_ID_CLASS).attribute('src').text
      else
        # extract the image ID that is used to look up the base64 encoded image
        id = el.css(GOOGLE_IMAGE_ID_CLASS).attribute('id').value

        # look up real base64 encoded image value from extract_base64_images
        obj['image'] = base64_images[id]
      end

      # add object to results array
      results.push(obj)
    end

    # return pretty json of results array
    JSON.pretty_generate(results)
  end

  private

  # extract_base64_images parses the HTML file and generates a hash
  # where the key is the image ID as set by Google and value is the
  # base64 encoded image file, e.g.
  # {
  #   "kximg" => "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQA..."
  # }
  def extract_base64_images(nokogiri_doc)
    # initiate empty object to collect key value pairs,
    # where key is the image and value is the encoded image file
    links = {}

    # iterate over <script> tags in HTML document and find the
    # one that includes the function that sets the image sources
    nokogiri_doc.search('script').each do |script|
      if script.text.include?(GOOGLE_SET_IMAGE_SRC_FUNCTION)

        # split up script string by '_setImagesSrc' function to get each individual
        # function with corresponding actual image value
        script.text.split(GOOGLE_SET_INDIVIDUAL_IMAGE_SRC_FUNCTION).each do |func|

          # check whether function contains image identifier and
          # value for base64 image
          if func.match?(GOOGLE_BASE64_IMAGE_IDENTIFIER) && func.match?('data:image')
            # get image number
            image_number = func.split(GOOGLE_BASE64_IMAGE_IDENTIFIER).last.split("']").first

            # assemble base64 encoded image
            image = 'data:image' +
                    func.split('data:image').last.split(';')[0] +
                    ';' +
                    func.split('data:image').last.split(';')[1].gsub("'","").gsub("\\","")

            # add to links object
            links["#{GOOGLE_BASE64_IMAGE_IDENTIFIER+image_number}"] = image
          end
        end
      end
    end

    links
  end
end
