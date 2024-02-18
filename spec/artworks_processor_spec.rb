require 'spec_helper'
require_relative '../artworks_processor'
require 'open-uri'
require 'cgi'

# Simplified example of artwork element in type 1 carousel
el_1_string = <<~STRING
  <div>
    <a
      aria-label="The Starry Night"
      href="/search?gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&amp;npsic=0&amp;sa=X&amp;ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"
      title="The Starry Night (1889)"
      ><div class="klzc" style="margin-bottom: 0">
        <div
        >
          <g-img>
            <img
              id="kximg0"
              src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
              alt=""
          /></g-img>
        </div>
      </div>
      <div>
        <div class="kltat">
          <span>The Starry </span><wbr /><span
            >Night</span
          ><wbr />
        </div>
        <div class="ellip klmeta">1889</div>
      </div></a
    >
  </div>
STRING
el_type_1 = Nokogiri::HTML::DocumentFragment.parse(el_1_string).at_css('*')

# Simplified example of artwork element in type 1 carousel without date text
el_1_string_without_date = <<~STRING
  <div>
    <a
      aria-label="The Starry Night"
      href="/search?gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&amp;npsic=0&amp;sa=X&amp;ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"
      title="The Starry Night (1889)"
      ><div class="klzc" style="margin-bottom: 0">
        <div
        >
          <g-img>
            <img
              id="kximg0"
              src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
              alt=""
          /></g-img>
        </div>
      </div>
      <div>
        <div class="kltat">
          <span>The Starry </span><wbr /><span
            >Night</span
          ><wbr />
        </div>
        <div class="ellip klmeta"></div>
      </div></a
    >
  </div>
STRING
el_type_1_without_date = Nokogiri::HTML::DocumentFragment.parse(el_1_string_without_date).at_css('*')

# Simplified script with img src values from document with type 1 carousel
script_1_string = <<-STRING
  <script nonce="lOsRZRlq+Dr1LlZhVtLxFg==">function _setImagesSrc(e,c){function f(a){a.onerror=function(){a.style.display="none"};a.src=c}for(var g=0,b=void 0;b=e[g++];){var d=document.getElementById(b);d?f(d):(google.iir=google.iir||{},google.iir[b]=c)}};(function(){var s='data:image/jpeg;base64,/9j/4AAQSkZJRgABAkUqVKspsbgj\x3d';var ii=['kximg0'];_setImagesSrc(ii,s);})();</script>
STRING
doc_with_script_1 = Nokogiri::HTML(script_1_string, nil, Encoding::UTF_8.to_s)

# Simplified example of artwork element from type 2 carousel
el_2_string = <<~STRING
  <div>
    <a title="Red Plastic"
      href="/search?sca_esv=8c3ea7e49633cccf&amp;biw=1920&amp;bih=1003&amp;q=Red+Plastic&amp;stick=H4sIAAAAAAAAAONgFuLUz9U3SMqpzEpW4tVP1zc0TM4uyUiuMq3QUspOttIvyywuTcyJTywqQWJmFpdYlecXZRcvYuUOSk1RCMhJLC7JTN7ByggAF81321EAAAA&amp;sa=X&amp;ved=2ahUKEwjZiv3o7rKEAxVcgP0HHenLBKEQgOQBegQILhAE"
      ><div>
        <div>
          <img
            id="_VejQZZmMEdyA9u8P6ZeTiAo_50"
            src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
          />
        </div>
      </div>
      <div>
        <div>
          <div>
            <div>
              Red Plastic
            </div>
            <div>
              <div>
                1961
              </div>
            </div>
          </div>
        </div>
      </div>
    </a>
  </div>
STRING
el_type_2 = Nokogiri::HTML::DocumentFragment.parse(el_2_string).at_css('*')

# Simplified script with img src values from document with type 2 carousel
script_2_string = <<~STRING
  <script nonce="tT-qKXnxWrR9WvDHdCzcsA">(function(){var s='data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQAB\x3d';var ii=['_VejQZZmMEdyA9u8P6ZeTiAo_50'];_setImagesSrc(ii,s);})();</script>
STRING
doc_with_script_2 = Nokogiri::HTML(script_2_string, nil, Encoding::UTF_8.to_s)

describe CarouselSharedMethods do
  include CarouselSharedMethods

  describe '#get_href' do
    it 'warns if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect { get_href(non_nokogiri_element) }.to output(
        /Expected a Nokogiri::XML::Element but received String/
      ).to_stderr
    end

    it 'returns nil if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect(get_href(non_nokogiri_element)).to be_nil
    end

    it 'returns nil if no relevant anchor element is found' do
      doc = Nokogiri::HTML('<div></div>')
      el = doc.at_css('div')
      expect(get_href(el)).to be_nil
    end

    it 'returns nil if relevant anchor element has no href' do
      doc = Nokogiri::HTML('<div><a></a></div>')
      el = doc.at_css('div')
      expect(get_href(el)).to be_nil
    end

    it "extracts anchor's href from elments in type one carousels" do
      expect(get_href(el_type_1)).to eq(CGI.unescapeHTML('https://www.google.com/search?gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&amp;npsic=0&amp;sa=X&amp;ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw'))
    end

    it "extracts anchor's href from elments in type two carousels" do
      expect(get_href(el_type_2)).to eq(CGI.unescapeHTML('https://www.google.com/search?sca_esv=8c3ea7e49633cccf&amp;biw=1920&amp;bih=1003&amp;q=Red+Plastic&amp;stick=H4sIAAAAAAAAAONgFuLUz9U3SMqpzEpW4tVP1zc0TM4uyUiuMq3QUspOttIvyywuTcyJTywqQWJmFpdYlecXZRcvYuUOSk1RCMhJLC7JTN7ByggAF81321EAAAA&amp;sa=X&amp;ved=2ahUKEwjZiv3o7rKEAxVcgP0HHenLBKEQgOQBegQILhAE'))
    end
  end

  describe '#get_img_src' do
    it 'warns nil if first argument is not a Nokogiri::HTML4::Document' do
      non_doc = "I'm not a doc. I'm a string."
      el = Nokogiri::HTML('<html><div></div></html>').at_css('div')
      expect do
        get_img_src(non_doc, el)
      end.to output("Expected a Nokogiri::HTML4::Document but received String\n").to_stderr
    end

    it 'returns nil if first argument is not a Nokogiri::HTML4::Document' do
      non_doc = "I'm not a doc. I'm a string."
      el = Nokogiri::HTML('<html><div></div></html>').at_css('div')
      expect(get_img_src(non_doc, el)).to be_nil
    end

    it 'warns nil if second argument is not a Nokogiri::XML::Element' do
      doc = Nokogiri::HTML('<html></html>')
      el = "I'm not an el. I'm a string."
      expect { get_img_src(doc, el) }.to output("Expected a Nokogiri::XML::Element but received String\n").to_stderr
    end

    it 'returns nil if first argument is not a Nokogiri::XML::Element' do
      doc = Nokogiri::HTML('<html></html>')
      el = "I'm not an el. I'm a string."
      expect(get_img_src(doc, el)).to be_nil
    end

    it 'returns nil if no img is found' do
      doc = Nokogiri::HTML('<html></html>')
      el = doc.at_css('img')
      expect(get_img_src(doc, el)).to be_nil
    end

    it 'returns nil if img does not have an id' do
      doc = Nokogiri::HTML('<html><img class="foo"/></html>')
      el = doc.at_css('img')
      expect(get_img_src(doc, el)).to be_nil
    end

    it 'returns nil if no matching script is found' do
      doc = Nokogiri::HTML('<html><div><img id="foo"/></div></html>')
      el = doc.at_css('div')
      expect(get_img_src(doc, el)).to be_nil
    end

    it 'should retrieve src in doc with type one carousel' do
      expect(get_img_src(doc_with_script_1, el_type_1)).to eq('data:image/jpeg;base64,/9j/4AAQSkZJRgABAkUqVKspsbgj=')
    end

    it 'should retrieve src in doc with type two carousel' do
      expect(get_img_src(doc_with_script_2, el_type_2)).to eq('data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQAB=')
    end
  end
end

describe CarouselTypeOne do
  include CarouselTypeOne

  describe '#get_name' do
    it 'warns if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect do
        get_name(non_nokogiri_element)
      end.to output("Expected a Nokogiri::XML::Element but received String\n").to_stderr
    end

    it 'returns nil if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect(get_name(non_nokogiri_element)).to be_nil
    end

    it 'returns nil if anchor element is not found' do
      doc = Nokogiri::HTML('<div>I am a div without an anchor element child</div>')
      el = doc.at_css('div')
      expect(get_name(el)).to be_nil
    end

    it 'extracts the name' do
      doc = Nokogiri::HTML('<div><a aria-label="Starry Night"></a></div>')
      el = doc.at_css('div')
      expect(get_name(el)).to eq('Starry Night')
    end
  end

  describe '#get_date' do
    it 'warns if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect do
        get_href(non_nokogiri_element)
      end.to output("Expected a Nokogiri::XML::Element but received String\n").to_stderr
    end

    it 'returns nil if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect(get_date(non_nokogiri_element)).to be_nil
    end

    it 'returns nil if relevant descendant element is not found' do
      doc = Nokogiri::HTML('<div></div>')
      el = doc.at_css('div')
      expect(get_date(el)).to be_nil
    end

    it 'returns nil if relevant descendant element has not text' do
      expect(get_date(el_type_1_without_date)).to be_nil
    end

    it 'extracts the date' do
      expect(get_date(el_type_1)).to eq('1889')
    end
  end
end

describe CarouselTypeTwo do
  include CarouselTypeTwo

  describe '#get_name' do
    it 'warns if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect do
        get_name(non_nokogiri_element)
      end.to output("Expected a Nokogiri::XML::Element but received String\n").to_stderr
    end

    it 'returns nil if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect(get_name(non_nokogiri_element)).to be_nil
    end

    it 'extracts the name' do
      doc = Nokogiri::HTML('<div><a title="Mona Lisa"></a></div>')
      el = doc.at_css('div')
      expect(get_name(el)).to eq('Mona Lisa')
    end
  end

  describe '#get_date' do
    it 'warns if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect do
        get_href(non_nokogiri_element)
      end.to output("Expected a Nokogiri::XML::Element but received String\n").to_stderr
    end

    it 'returns nil if the argument is not a Nokogiri element' do
      non_nokogiri_element = 'This is a string, not a Nokogiri element'
      expect(get_date(non_nokogiri_element)).to be_nil
    end

    it 'extracts the date' do
      expect(get_date(el_type_2)).to eq('1961')
    end
  end
end

describe ArtworkProcessor do
  describe '#find_artworks_container' do
    let(:processor) { ArtworkProcessor.new(document) }

    context 'when document does match expected structure' do
      let(:document) { Nokogiri::HTML('<body><div>Hola</div></body>') }

      it 'returns nil' do
        result = processor.send(:find_artworks_container)
        expect(result).to be_nil
      end
    end

    context 'when type 1 carousel is present' do
      let(:document) { Nokogiri::HTML(URI.open('files/van-gogh-paintings.html'), nil, Encoding::UTF_8.to_s) }

      it 'returns an appropriately tagged div' do
        result = processor.send(:find_artworks_container)
        expect(result[:type]).to eq('1')
        expect(result[:el].name).to eq('div')
      end
    end

    context 'when type 2 carousel is present' do
      let(:document) { Nokogiri::HTML(URI.open('files/alberto-burri.html'), nil, Encoding::UTF_8.to_s) }

      it 'returns an appropriately tagged div' do
        result = processor.send(:find_artworks_container)
        expect(result[:type]).to eq('2')
        expect(result[:el].name).to eq('div')
      end
    end
  end

  describe '#process_artworks' do
    let(:processor) { ArtworkProcessor.new('dummy document') }

    context 'when called with an invalid argument' do
      it 'warns about the expected argument type' do
        invalid_arg = 'not a nokogiri element'
        expect do
          processor.send(:process_artworks, invalid_arg)
        end.to output("Expected a Nokogiri::XML::Element but received String\n").to_stderr
      end

      it 'returns an empty array' do
        invalid_arg = 'not a nokogiri element'
        result = processor.send(:process_artworks, invalid_arg)
        expect(result).to eq([])
      end
    end
  end
end
