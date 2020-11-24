require 'fileutils'
require 'json'
require 'nokogiri'

module Parser
  class Google
    DOMAIN = 'https://www.google.com'

    attr_accessor :output

    def initialize(filename)
      @doc = Nokogiri::HTML(File.read(filename))
    end

    def parse_carousel
      @output = carousel_items.map do |item|
        extension_text = extension(item)
        base64 = get_full_base64(image_id(item))

        result = { name: name(item) }
        result.merge!( extension: [extension_text] ) if extension_text
        result.merge!( link: link(item), image: base64 )
      end

      @output
    end

    def to_json
      JSON.pretty_generate({ artworks: @output })
    end

    def to_file
      FileUtils.mkdir_p('outputs')
      File.write(
        "outputs/#{File.basename(ARGV[0], '.html')}.json",
        self.to_json
      )
    end


    private

    def carousel_items
      @carousel_items ||= @doc.xpath('//*[@class="klitem"]')
    end

    def name(item)
      item.at_xpath('div/div[contains(@class, "kltat")]').text
    end

    def extension(item)
      item.at_xpath('div/div[contains(@class, "klmeta")]')&.text
    end

    def link(item)
      DOMAIN + item.xpath('@href').text
    end

    def image_id(item)
      item.at_xpath('div/div/g-img/img/@id').text
    end

    def get_full_base64(selector)
      regex = %r{
        var\ss\=\'                                  # Match the variable assignment
        (((?!var\ss\=)[\s\S])+?)\';                 # Match the base64 string
        var\sii\=\[\'#{Regexp.quote(selector)}\'\]  # Match the element id
      }x

      @script ||= collect_image_src_scripts

      @script[regex, 1]
    end

    def collect_image_src_scripts
      combined_scripts = ''

      @doc.xpath(
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
  end
end
