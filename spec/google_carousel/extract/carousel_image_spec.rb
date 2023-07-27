require 'rspec_helper'

describe GoogleCarousel::Extract::CarouselImage do
  before do
    doc = Nokolexbor::HTML <<-HTML
      <script>
        function _setImagesSrc(e,c){function f(a){a.onerror=function(){a.style.display="none"};a.src=c}for(var g=0,b=void 0;b=e[g++];){var d=document.getElementById(b);d?f(d):(google.iir=google.iir||{},google.iir[b]=c)}};(function(){var s='data:image/jpeg;base64,/9j/4AAQSkZJ';var ii=['dimg_91'];});
      </script>
    HTML

    @img_sources = described_class.new(doc).fetch_images
  end

  it 'parses the carousel images correctly' do
    expect(@img_sources).not_to be_empty
    expect(@img_sources.keys.first).to eq('dimg_91')
    expect(@img_sources.values.first).to eq('data:image/jpeg;base64,/9j/4AAQSkZJ')
  end
end
