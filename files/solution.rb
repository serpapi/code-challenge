require 'fileutils'
require 'json'
require 'nokogiri'

DOMAIN = 'https://www.google.com'

def parse_carousel(filename)
  doc = Nokogiri::HTML(File.read(filename))

  output = doc.xpath('//*[@class="klitem"]').map do |item|
    name = item.at_xpath('div/div[contains(@class, "kltat")]').text
    extension = item.at_xpath('div/div[contains(@class, "klmeta")]')&.text

    link = DOMAIN + item.xpath('@href').text
    image_id = item.at_xpath('div/div/g-img/img/@id').text

    base64 = get_full_base64(doc, image_id)

    result = { name: name }
    result.merge!( extension: [extension] ) if extension
    result.merge!( link: link, image: base64 )
  end

  FileUtils.mkdir_p('outputs')
  File.write(
    "outputs/#{File.basename(ARGV[0], '.html')}.json",
    JSON.pretty_generate({ artworks: output })
  )
end

def get_full_base64(doc, selector)
  regex = %r{
    var\ss\=\'                                  # Match the variable assignment
    (((?!var\ss\=)[\s\S])+?)\';                 # Match the base64 string
    var\sii\=\[\'#{Regexp.quote(selector)}\'\]  # Match the element id
  }x

  @script ||= collect_image_src_scripts(doc)

  @script[regex, 1]
end

# NB: The van-gogh-paintings example is a little outdated/different from
# the current search results of Google. In the van gogh example, the script
# that assigns the base64 img src is in one <script> tag. While in the current
# search result, the script is split into multiple <script> tags. This method
# collects all script tags so that it handles both the van gogh example and the
# current search result format.
def collect_image_src_scripts(doc)
  combined_scripts = ''

  doc.xpath(
    '/html/body/div[@id="main"]/div[@id="cnt"]' \
    '/script[starts-with(text(), "function _setImagesSrc")]' \
    ' | ' \
    '//div[@id="search"]/div/div[@id="rso"]' \
    '/script[contains(text(), "setImagesSrc")]'
  ).each do |script|
    combined_scripts << script.text.gsub('\\x3d', '=')
  end

  combined_scripts
end

parse_carousel(ARGV[0])
