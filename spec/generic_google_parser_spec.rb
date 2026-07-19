require 'rspec'
require 'json'
require 'uri'
require_relative '../modules/generic_google_parser'

RSpec.describe GenericGoogleParser do
  let(:parser) { GenericGoogleParser.new }

  def q_and_stick(link)
    params = URI.decode_www_form(URI(link).query).to_h
    "#{params['q']}#{params['stick']}"
  end

  describe '#parse' do
    context 'when carousel is present' do
      context 'with painting collection (van gogh) 2024 - challenge data' do
        let(:html) { File.read('spec/fixtures/2024/van-gogh-paintings.html') }
        let(:expected) { JSON.parse(File.read('spec/fixtures/2024/expected-array.json')) }
        let(:paintings) { JSON.parse(parser.parse(html)) }

        it 'matches the expected array' do
          expect(paintings).to eq(expected)
        end
      end

      context 'with painting collection (van gogh) 2026' do
        let(:html) { File.read('spec/fixtures/2026/carousel-paintings-van-gogh.html') }
        let(:paintings) { JSON.parse(parser.parse(html)) }

        it 'returns the expected first artwork' do
          painting = paintings['artworks'].first

          expect(painting['name']).to eq('The Starry Night')
          expect(painting['extensions']).to eq(["1889"])
          expect(painting['image']).to start_with("data:image/jpeg;base64,")
          expect(painting['link']).to start_with("https://www.google.com")
        end
      end

      context 'with multi-value extensions (rammstein)' do
        let(:html) { File.read('spec/fixtures/2026/carousel-multi-extension-members-rammstein.html') }
        let(:members) { JSON.parse(parser.parse(html)) }

        it 'handles multi-value extensions' do
          member = members['members'][3]

          expect(member['name']).to eq('Christoph Schneider')
          expect(member['extensions']).to eq(["Drum Kit", "Since 1994"])
        end
      end

      context 'with cast member collection (star trek tng)' do
        let(:html) { File.read('spec/fixtures/2026/carousel-cast-star-trek-tng.html') }
        let(:cast) { JSON.parse(parser.parse(html)) }

        it 'returns the expected key with an array of cast members' do
          expect(cast).to have_key('cast')
          expect(cast['cast']).to be_an(Array)
          expect(cast['cast']).not_to be_empty
        end

        it 'returns a name, image, link, and extensions when scraped from wp-grid-tile' do
          # worth noting that google has placed number one at number zero!
          actor = cast['cast'][0]

          expect(actor['name']).to eq('Jonathan Frakes')
          expect(actor['image']).to start_with("data:image/jpeg;base64,")
          expect(actor['link']).to start_with("https://www.google.com")
          expect(actor['extensions']).to eq(["William T. Riker"])
        end
      end
    end

    context 'when carousel is not present' do
      # this was an odd false-positive situation i encountered before explicitly calling out overview as a special case
      context 'when selected knowledge panel tab is overview (muppets)' do
        let(:html) { File.read('spec/fixtures/2026/no-carousel-overview-muppets.html') }
        it 'raises a parse error (overview has no carousel)' do
          expect { parser.parse(html) }.to raise_error(GenericGoogleParser::ParseError, 'Knowledge Panel overview has no carousel')
        end
      end

      context 'when selected knowledge panel tab is not a carousel (star trek tng)' do
        let(:html) { File.read('spec/fixtures/2026/no-carousel-episodes-star-trek-tng.html') }
        it 'raises a parse error (no carousel found)' do
          expect { parser.parse(html) }.to raise_error(GenericGoogleParser::ParseError, 'No carousel found in Knowledge Panel')
        end
      end

      # context 'when knowledge panel is not present' do
      #   let(:html) { File.read('spec/fixtures/2026/no-knowledge-panel-ruby-on-rails.html') }
      #   it 'raises a parse error (no knowledge panel found)' do
      #     expect { parser.parse(html) }.to raise_error(GenericGoogleParser::ParseError, 'No Knowledge Panel was found')
      #   end
      # end

      # NOTE: begin new specs
      context 'when appbar is present' do
        let(:html) { File.read('spec/fixtures/live-coding/popes-raw.html') }
        let(:expected) { JSON.parse(File.read('spec/fixtures/live-coding/popes-playground-result.json')) }
        let(:popes) { JSON.parse(parser.parse(html)) }

        it 'returns the expected key with an array of popes' do
          expect(popes).to have_key('popes')
          expect(popes['popes']).to be_an(Array)
          expect(popes['popes']).not_to be_empty
        end

        it 'returns the expected current pope' do
          pope = popes['popes'][0]
          expected_pope = expected['popes'][0]

          expect(pope['name']).to eq(expected_pope['name'])
          expect(q_and_stick(pope['link'])).to eq(q_and_stick(expected_pope['link']))
          expect(pope['image']).to start_with("data:image/jpeg;base64,")
        end

        it 'returns the expected first pope' do
          pope = popes['popes'].last
          expected_pope = expected['popes'].last

          expect(pope['name']).to eq(expected_pope['name'])
          expect(q_and_stick(pope['link'])).to eq(q_and_stick(expected_pope['link']))
          expect(pope['image']).to eq(expected_pope['image'])
        end
      end
    end
  end
end