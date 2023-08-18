# frozen_string_literal: true

require 'spec_helper'
require 'json'

describe Parser::Google::ImageContainer do
  let(:html) do
    <<~HTML
      <a class="klitem" aria-label="The Starry Night" aria-posinset="1" aria-setsize="51" data-sp="0,17,26" href="/search?gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&amp;npsic=0&amp;sa=X&amp;ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw" style="height:193px;width:120px" title="The Starry Night (1889)" role="button" data-hveid="47" data-ved="0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"><div class="klzc" style="margin-bottom:0"><div class="klic" style="height:120px;width:120px"><g-img class="BA0A6c" style="height:120px;width:120px"><img data-key="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0" id="kximg0" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-deferred="1" class="rISBZc M4dUYb" height="120" width="120" alt=""></g-img></div></div>
      <div>
      <div class="kltat">
      <span>The Starry </span><wbr><span>Night</span><wbr></wbr></wbr>
      </div>
      <div class="ellip klmeta">1889</div>
      </div></a>
    HTML
  end
  let(:image_element) do
    Nokogiri::HTML(html, nil, Encoding::UTF_8.to_s).css('a').first
  end
  let(:image_container) { described_class.new image_element }

  describe '#name' do
    it 'returns name from the aria-label' do
      expect(image_container.name).to eq 'The Starry Night'
    end
  end

  describe '#extensions' do
    it 'returns year of artworks' do
      expect(image_container.extensions).to eq ['1889']
    end

    context 'when image element does not contains year information' do
      let(:html) do
        <<~HTML
          <a class="klitem" aria-label="The Starry Night" aria-posinset="1" aria-setsize="51" data-sp="0,17,26" href="/search?gl=us&amp;hl=en&amp;q=The+Starry+Night&amp;stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&amp;npsic=0&amp;sa=X&amp;ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw" style="height:193px;width:120px" title="The Starry Night (1889)" role="button" data-hveid="47" data-ved="0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw"><div class="klzc" style="margin-bottom:0"><div class="klic" style="height:120px;width:120px"><g-img class="BA0A6c" style="height:120px;width:120px"><img data-key="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq3gOqqnprlNb3SdEgrKAR_0sWrsu0kO0aNnwE3yRwmA_cf-PvBvdz4eInim3FDmRn7E0" id="kximg0" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-deferred="1" class="rISBZc M4dUYb" height="120" width="120" alt=""></g-img></div></div>
          <div>
          <div class="kltat">
          <span>The Starry </span><wbr><span>Night</span><wbr></wbr></wbr>
          </div>
          </div></a>
        HTML
      end
      it 'returns nil' do
        expect(image_container.extensions).to be_nil
      end
    end
  end

  describe '#link' do
    it 'returns search link of artwork' do
      search_link = 'https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw'
      expect(image_container.link).to eq search_link
    end
  end

  describe '#image_id' do
    it 'returns image id of the element' do
      expect(image_container.image_id).to eq 'kximg0'
    end
  end
end
