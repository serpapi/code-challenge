module Parser
  module Google
    class Carousel < Google
      FILE_PATH = './files/van-gogh-paintings.html'.freeze

      HTML_STRUCTURE = {
        container: '.klcc',
        item: '.klitem',
        title: '.kltat',
        year: '.klmeta',
        image: '.klic g-img img'
      }.freeze

      SCRIPT_PATTERN = "//script[contains(., '_setImagesSrc')]".freeze

      # NOTE: This will fail if the HTML is not minified!
      #
      # We could introduce `\s?` in the regexp to make it work with either minified or non-minified HTML, but I don't
      # think it's worth it for this challenge and it also makes the regexp more complex and harder to read.
      #
      IMAGE_PATTERN = /var ii=\['(.*?)'\].*?s='(.*?)';var ii/.freeze

      def call
        doc.css(HTML_STRUCTURE[:item]).map do |item|

          # NOTE: I haven't come across a `nil` item, but it's a good practice to ensure we don't break the code if we
          # get a `nil` item.
          #
          next unless item

          build_result(item)
        end
      end

      private

      def build_image_id_to_base64_map
        @_build_image_id_to_base64_map ||= begin
          doc = parse_file

          scripts = doc.xpath(SCRIPT_PATTERN).text
          scripts.scan(IMAGE_PATTERN).each_with_object({}) do |(id, image_base64), images|

            # Using `scan()` with a regexp gives us a more accurate capture and this
            # is not needed anymore, but just for an extra layer of safety, we can
            # skip the image if it doesn't start with the expected prefix.
            #
            next unless image_base64.include?(BASE64_PREFIX)

            # NOTE: We need to replace the escaped `=` with the actual `=` sign
            #
            images.merge!(id => image_base64.gsub(/\\x3d/, '='))
          end
        end
      end

      def build_result(item)

        # NOTE: It's a good practice to extract each attribute to a separate method. It makes the code more readable and
        # it allows us to easily test each one in isolation and make sure it returns the expected value, or raise an
        # error if it doesn't.
        #
        # For the sake of this challenge, I'm not going to do it, but I would do it in a real project.
        #
        {
          name: item.attr('aria-label'),
          extensions: [item.css(HTML_STRUCTURE[:year])&.text&.strip],
          link: URI.join(BASE_URL, item.attr('href')).to_s,
          image: build_image_id_to_base64_map[item.css(HTML_STRUCTURE[:image]).attr('id').value]
        }
      end
    end
  end
end