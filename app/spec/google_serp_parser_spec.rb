require 'google_serp_parser'
require 'json'


RSpec::Matchers.define :be_inline_image do |image|
  match do |image|
    # A placeholder white pixel GIF is around ~80 chars.
    !image.nil? && image.start_with?('data:image/') && image.size > 256
  end
end


RSpec::Matchers.define :be_optional_inline_image do |image|
  match do |image|
    expect(image).to be_inline_image.or(be_nil)
  end
end


shared_context 'SERP with carousel' do |source_html, expected_name|
  let(:parser) { GoogleSerpParser.new(source_html) }
  let(:output) { parser.parse_carousel }

  it 'should return an object with one item' do
    expect(output).to be_an(Object)
    expect(output.size).to eq(1)
    expect(output.first).to be_an(Array)
  end

  let(:name) { output.keys[0] }
  let(:items) { output.values[0] }

  it 'should use the correct carousel name' do
    expect(name).to eq(expected_name)
  end

  it 'should return objects with proper types' do
    expect(items).to all(match(
      'name' => be_a(String),
      'extensions' => all(be_a(String)),
      'link' => start_with('https://'),
      'image' => be_optional_inline_image,
    ))
  end
end


describe GoogleSerpParser do
  describe 'NFL teams' do
    it_behaves_like('SERP with carousel',
                    'spec/support/nfl-teams.html',
                    'teams') do
      it 'should include Minnesota Vikings' do
        expect(items).to include(include('name' => 'Minnesota Vikings'))
      end
      it 'should not have any extensions' do
        expect(items).to all(include('extensions' => []))
      end
    end
  end

  describe 'Paypal founders' do
    it_behaves_like('SERP with carousel',
                    'spec/support/paypal-founders.html',
                    'founders') do
      it 'should include Peter Thiel' do
        expect(items).to include(include('name' => 'Peter Thiel'))
      end
      it 'should not have any extensions' do
        expect(items).to all(include('extensions' => []))
      end
    end
  end

  describe 'Prime Ministers of Canada' do
    it_behaves_like('SERP with carousel',
                    'spec/support/prime-ministers-of-canada.html',
                    'prime-ministers') do
      it 'should have Justin Trudeau and his details as the first item' do
        expect(items.first).to include(
          'name' => 'Justin Trudeau',
          'extensions' => [start_with('2015')],
          'link' => include('Justin+Trudeau'),
          'image' => be_inline_image,
        )
      end
    end
  end

  describe 'Yankees roster' do
    it_behaves_like('SERP with carousel',
                    'spec/support/yankees-roster.html',
                    'players') do
      it 'should specify Gerrit Cole as a pitcher' do
        expect(items).to include(include(
          'name' => 'Gerrit Cole',
          'extensions' => ['Pitcher'],
          'link' => include('Gerrit+Cole'),
        ))
      end
    end
  end

  describe 'Van Gogh paintings' do
    it_behaves_like('SERP with carousel',
                    'spec/support/van-gogh-paintings.html',
                    'artworks') do
      it 'should match expected JSON file' do
        expected_json = 'spec/support/van-gogh-paintings_expected.json'
        expected = JSON.load(File.read(expected_json))
        expect(output).to match(expected)
      end
    end
  end
end
