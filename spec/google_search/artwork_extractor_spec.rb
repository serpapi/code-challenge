# frozen_string_literal: true

require "digest"

RSpec.describe GoogleSearch::ArtworkExtractor do
  subject(:result) { extract(html) }

  def extract(source_html)
    described_class.new(source_html).call
  end

  let(:placeholder_image) do
    "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
  end

  context "with the supplied Van Gogh result page" do
    let(:html) { fixture_file("files", "van-gogh-paintings.html") }
    let(:expected_result) { json_fixture("files", "expected-array.json") }
    let(:expected_artworks) { expected_result.fetch("artworks") }
    let(:artworks) { result.fetch("artworks") }

    describe "Van Gogh output details" do
      it "returns all 47 cards in source order across the visible and hidden boundary" do
        names = artworks.map { |artwork| artwork.fetch("name") }

        expect(names.length).to eq(47)
        expect(names.values_at(0, 7, 8, 46)).to eq(
          [
            "The Starry Night",
            "Self-Portrait",
            "Self-Portrait with Bandaged Ear",
            "Poppy Flowers"
          ]
        )
      end

      it "omits extensions only for the four cards whose source extension is blank" do
        extension_arrays = artworks.filter_map { |artwork| artwork["extensions"] }
        names_without_extensions = artworks.reject { |artwork| artwork.key?("extensions") }
          .map { |artwork| artwork.fetch("name") }
        extensions_are_present = extension_arrays.all? do |extensions|
          extensions.one? && extensions.first.is_a?(String) && !extensions.first.strip.empty?
        end

        expect(extension_arrays.length).to eq(43)
        expect(extensions_are_present).to be(true)
        expect(names_without_extensions).to eq(
          [
            "Sunflowers",
            "Mulberry Tree",
            "Skull of a Skeleton with Burning Cigarette",
            "Vase with Cornflowers and Poppies"
          ]
        )
      end

      it "associates and decodes the eight inline JPEG sources" do
        images = artworks.map { |artwork| artwork.fetch("image") }

        expect(images.count { |image| image.start_with?("data:image/jpeg;base64,") }).to eq(8)
        expect(Digest::SHA256.hexdigest(images[0])).to eq(
          "3283e501c1e437ddc7a266dc497ee0bbf78fc4f625813f612a068dfc1bc03339"
        )
        expect(images[1]).to end_with("=")
        expect(images[2]).to end_with("==")
      end

      it "preserves all 39 image URLs stored in data-src" do
        images = artworks.map { |artwork| artwork.fetch("image") }

        expect(images.count { |image| image.start_with?("https://") }).to eq(39)
        expect(images[8]).to eq(
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8juuefle5MyKZKBLRgPjsGSJon7vkt91SM7WTRuZOOyAyUI1v"
        )
      end

      it "never returns the one-pixel placeholder GIF" do
        images = artworks.map { |artwork| artwork.fetch("image") }

        expect(images).not_to include(placeholder_image)
      end

      it "resolves relative links without reserializing their query strings" do
        links = artworks.map { |artwork| artwork.fetch("link") }
        cafe_link = artworks.find { |artwork| artwork.fetch("name") == "Café Terrace at Night" }.fetch("link")

        expect(links).to all(start_with("https://www.google.com/search?"))
        expect(links.first).to eq(expected_artworks.first.fetch("link"))
        expect(cafe_link).to include("q=Caf%C3%A9+Terrace+at+Night")
      end

      it "preserves UTF-8 names and source punctuation" do
        names = artworks.map { |artwork| artwork.fetch("name") }

        expect(names).to include(
          "Café Terrace at Night",
          "The Night Café",
          "Starry Night Over the Rhône",
          "Van Gogh's Chair",
          "L'Arlésienne",
          "At Eternity's Gate"
        )
      end

      it "uses the expected key order without nil or empty values on this page" do
        sunflowers = artworks.find { |artwork| artwork.fetch("name") == "Sunflowers" }
        observed_keys = artworks.flat_map(&:keys).uniq
        supplied_page_values = artworks.flat_map do |artwork|
          [ artwork.fetch("name"), artwork.fetch("link"), artwork.fetch("image") ]
        end

        expect(artworks.first.keys).to eq([ "name", "extensions", "link", "image" ])
        expect(sunflowers.keys).to eq([ "name", "link", "image" ])
        expect(observed_keys).to match_array([ "name", "extensions", "link", "image" ])
        expect(supplied_page_values).to all(be_a(String))
        expect(supplied_page_values).to all(satisfy { |value| !value.strip.empty? })
      end
    end
  end

  context "when Google-generated classes and JavaScript attributes are absent" do
    def without_generated_attributes(source_html)
      html = source_html.dup
      html.force_encoding(Encoding::UTF_8) if html.encoding == Encoding::BINARY
      document = Nokolexbor::HTML(html)
      attributes = %w[class jsname jscontroller jsdata jsaction data-md data-hveid data-ved data-atf data-csiid]
      attributes.each do |attribute|
        document.css("[#{attribute}]").remove_attribute(attribute)
      end

      document.to_html
    end

    it "still matches every saved expected result using the artwork marker and HTML shape" do
      aggregate_failures do
        saved_page_fixtures.each do |saved_page|
          stripped_html = without_generated_attributes(fixture_file(saved_page.html_path))
          expected = json_fixture(saved_page.expected_path)

          expect(extract(stripped_html)).to eq(expected), saved_page.html_path
        end
      end
    end
  end

  context "with focused HTML examples" do
    def artwork_section_page(cards:, scripts: "")
      <<~HTML
        <!doctype html>
        <html>
          <head>
            <meta charset="UTF-8">
            #{scripts}
          </head>
          <body>
            <div data-attrid="kc:/visual_art/visual_artist:works">
            <div>#{cards}</div>
            </div>
          </body>
        </html>
      HTML
    end

    it "rejects a plausible card outside Google's artwork section" do
      html = <<~HTML
        <!doctype html>
        <h2 role="heading">Artworks</h2>
        <div>
          <div>
            <a href="/search?q=Outside+Root">
              <img alt="Outside Root" data-src="https://images.example/outside.jpg">
              <div>Outside Root</div>
            </a>
          </div>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::ArtworkSectionNotFound,
        /artwork section/i
      )
    end

    it "extracts fields without consulting their classes" do
      html = artwork_section_page(cards: <<~HTML)
        <div class="ignored-card-class">
          <a href="/search?q=Rotated+Fields">
            <img alt="Rotated Fields" data-src="https://images.example/rotated-fields.jpg">
            <div class="ignored-details-class">
              <div class="ignored-name-class">Rotated Fields</div>
              <div class="ignored-extension-class">2026</div>
            </div>
          </a>
        </div>
      HTML

      expect(extract(html)).to eq(
        {
          "artworks" => [
            {
              "name" => "Rotated Fields",
              "extensions" => [ "2026" ],
              "link" => "https://www.google.com/search?q=Rotated+Fields",
              "image" => "https://images.example/rotated-fields.jpg"
            }
          ]
        }
      )
    end

    it "reads the second displayed field as extensions" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Rotated+Extension">
            <img alt="Rotated Extension" data-src="https://images.example/rotated-extension.jpg">
            <div>
              <div>Rotated Extension</div>
              <div>2026</div>
            </div>
          </a>
        </div>
      HTML

      expect(extract(html).fetch("artworks").first.fetch("extensions")).to eq([ "2026" ])
    end

    it "retains a valid card with no extra displayed field" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=No+Extension+Element">
            <img alt="No Extension Element" data-src="https://images.example/no-extension.jpg">
            <div>
              <div>No Extension Element</div>
            </div>
          </a>
        </div>
      HTML

      expect(extract(html).fetch("artworks").first).to eq(
        {
          "name" => "No Extension Element",
          "link" => "https://www.google.com/search?q=No+Extension+Element",
          "image" => "https://images.example/no-extension.jpg"
        }
      )
    end

    it "keeps every valid direct card regardless of classes" do
      html = artwork_section_page(cards: <<~HTML)
        <div class="first-ignored-class">
          <a href="/search?q=First+Card">
            <img alt="First Card" data-src="https://images.example/first.jpg">
            <div>
              <div>First Card</div>
              <div>1900</div>
            </div>
          </a>
        </div>
        <div class="second-ignored-class">
          <a href="/search?q=Second+Card">
            <img alt="Second Card" data-src="https://images.example/second.jpg">
            <div>
              <div>Second Card</div>
              <div>1901</div>
            </div>
          </a>
        </div>
      HTML

      expect(extract(html).fetch("artworks").map { |artwork| artwork.fetch("name") }).to eq(
        [ "First Card", "Second Card" ]
      )
    end

    it "fails instead of returning a partial result when one card is invalid" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Valid+Card">
            <img alt="Valid Card" data-src="https://images.example/valid.jpg">
            <div>
              <div>Valid Card</div>
              <div>1900</div>
            </div>
          </a>
        </div>
        <div>
          <a href="/search?q=Missing+Name">
            <img alt="Missing Name" data-src="https://images.example/missing.jpg">
            <div>
              <div>   </div>
              <div>1901</div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::MalformedCard,
        /card 2.*name/i
      )
    end

    it "rejects a valid card list nested inside a malformed possible list" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=First">
            <img alt="First" data-src="https://images.example/first.jpg">
            <div><div>First</div></div>
          </a>
        </div>
        <div>
          <div>
            <div>
              <a href="/search?q=Nested">
                <img alt="Nested" data-src="https://images.example/nested.jpg">
                <div><div>Nested</div></div>
              </a>
            </div>
          </div>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::ArtworkLayoutError,
        /unsupported HTML structure/i
      )
    end

    it "does not use a descendant SVG link when the card anchor has no href" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a>
            <img alt="Missing Structural Link" data-src="https://images.example/missing-link.jpg">
            <div>
              <div>
                Missing Structural Link
                <svg><a href="/search?q=Wrong+Link"></a></svg>
              </div>
              <div>1900</div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::MalformedCard,
        /card 1.*missing.*link/i
      )
    end

    it "uses the validated direct image for script recovery and output" do
      scripts = <<~HTML
        <script>
          var s = 'https://images.example/right.jpg';
          var ii = [ 'right-image' ];
          _setImagesSrc(ii, s);
        </script>
      HTML
      html = artwork_section_page(cards: <<~HTML, scripts: scripts)
        <div>
          <a href="/search?q=Right+Image">
            <div>
              <div>
                Right Image
                <img data-src="https://images.example/wrong.jpg">
              </div>
            </div>
            <img id="right-image" alt="Right Image" src="#{placeholder_image}">
          </a>
        </div>
      HTML

      expect(extract(html).fetch("artworks").first.fetch("image")).to eq(
        "https://images.example/right.jpg"
      )
    end

    it "does not treat extra text as the name when image alt text is missing" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Missing+Structural+Name">
            <img data-src="https://images.example/missing-structural-name.jpg">
            <div>
              <div>1889</div>
              <div></div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::MalformedCard,
        /card 1.*image alt text/i
      )
    end

    it "rejects a displayed name that conflicts with the image description" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Displayed+Name">
            <img alt="Different Name" data-src="https://images.example/conflict.jpg">
            <div>
              <div>Displayed Name</div>
              <div>1900</div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::MalformedCard,
        /card 1.*displayed name.*image alt text differ/i
      )
    end

    it "rejects descriptive image alt text that differs from the displayed name" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Known+Displayed+Name">
            <img alt="A framed oil painting" data-src="https://images.example/descriptive-alt.jpg">
            <div>
              <div>Known Displayed Name</div>
              <div>1900</div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::MalformedCard,
        /card 1.*displayed name.*image alt text differ/i
      )
    end

    it "rejects a card with more than two displayed fields" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Extra+Detail">
            <img alt="Extra Detail" data-src="https://images.example/extra-detail.jpg">
            <div>
              <div>Extra Detail</div>
              <div>1900</div>
              <div>Artwork</div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::ArtworkLayoutError,
        /unsupported HTML structure/i
      )
    end

    it "rejects an artwork section containing two possible card lists" do
      html = <<~HTML
        <!doctype html>
        <div data-attrid="kc:/visual_art/visual_artist:works">
          <div>
            <div>
              <a href="/search?q=First">
                <img alt="First" data-src="https://images.example/first.jpg">
                <div><div>First</div><div>1900</div></div>
              </a>
            </div>
          </div>
          <section>
            <div>
              <a href="/search?q=Second">
                <img alt="Second" data-src="https://images.example/second.jpg">
                <div><div>Second</div><div>1901</div></div>
              </a>
            </div>
          </section>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::ArtworkLayoutError,
        /more than one possible artwork card list/i
      )
    end

    it "ignores empty markup outside the only card list" do
      html = <<~HTML
        <!doctype html>
        <div data-attrid="kc:/visual_art/visual_artist:works">
          <div data-unrelated="empty"></div>
          <div>
            <div>
              <a href="/search?q=Recovered+Collection">
                <img alt="Recovered Collection" data-src="https://images.example/recovered.jpg">
                <div><div>Recovered Collection</div><div>1900</div></div>
              </a>
            </div>
          </div>
        </div>
      HTML

      expect(extract(html).fetch("artworks").first.fetch("name")).to eq("Recovered Collection")
    end

    it "does not extract a movies carousel" do
      html = <<~HTML
        <!doctype html>
        <div data-attrid="kc:/people/person:movies">
          <div title="Example Movie">
            <a href="/search?q=Example+Movie">
              <img data-src="https://images.example/movie.jpg">
              <div>Example Movie</div>
              <div>2026</div>
            </a>
          </div>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::ArtworkSectionNotFound,
        /artwork section/i
      )
    end

    it "rejects a supported root with no artwork cards while ignoring Show more" do
      html = <<~HTML
        <!doctype html>
        <div data-attrid="kc:/visual_art/visual_artist:works">
          <div></div>
          <a href="#">Show more</a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::ArtworkLayoutError,
        /no artwork cards/i
      )
    end

    it "rejects a card with no displayed name" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Missing+Name">
            <img data-src="https://images.example/missing-name.jpg">
            <div>
              <div>   </div>
              <div>1889</div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::MalformedCard,
        /card 1.*name/i
      )
    end

    it "rejects a card with no source link" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="   ">
            <img alt="Missing Link" data-src="https://images.example/missing-link.jpg">
            <div>
              <div>Missing Link</div>
              <div>1889</div>
            </div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::MalformedCard,
        /card 1.*link/i
      )
    end

    it "omits a whitespace-only extension while preserving the card" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=Whitespace+Year">
            <img alt="Whitespace Year" data-src="https://images.example/whitespace.jpg">
            <div>
              <div>Whitespace Year</div>
              <div>   </div>
            </div>
          </a>
        </div>
      HTML

      expect(extract(html)).to eq(
        {
          "artworks" => [
            {
              "name" => "Whitespace Year",
              "link" => "https://www.google.com/search?q=Whitespace+Year",
              "image" => "https://images.example/whitespace.jpg"
            }
          ]
        }
      )
    end

    it "retains a card but omits image when only the placeholder is available" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="/search?q=No+Local+Image">
            <img alt="No Local Image" src="#{placeholder_image}">
            <div>
              <div>No Local Image</div>
              <div>1900</div>
            </div>
          </a>
        </div>
      HTML

      expect(extract(html)).to eq(
        {
          "artworks" => [
            {
              "name" => "No Local Image",
              "extensions" => [ "1900" ],
              "link" => "https://www.google.com/search?q=No+Local+Image"
            }
          ]
        }
      )
    end

    it "rejects an unsafe artwork link scheme" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="javascript:alert(1)">
            <img alt="Unsafe Link" data-src="https://images.example/unsafe.jpg">
            <div><div>Unsafe Link</div><div></div></div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::InvalidLink,
        /card 1.*javascript/i
      )
    end

    it "rejects a malformed artwork link" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="http://[invalid">
            <img alt="Malformed Link" data-src="https://images.example/malformed-link.jpg">
            <div><div>Malformed Link</div><div></div></div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(
        GoogleSearch::InvalidLink,
        /card 1.*invalid link/i
      )
    end

    it "preserves an already absolute link on the allowed Google origin" do
      html = artwork_section_page(cards: <<~HTML)
        <div>
          <a href="https://www.google.com/search?q=Absolute+Link&amp;tbm=isch">
            <img alt="Absolute Link" data-src="https://images.example/absolute.jpg">
            <div><div>Absolute Link</div><div></div></div>
          </a>
        </div>
      HTML

      expect(extract(html).fetch("artworks").first.fetch("link")).to eq(
        "https://www.google.com/search?q=Absolute+Link&tbm=isch"
      )
    end

    it "rejects links outside the exact Google HTTPS origin" do
      invalid_links = [
        "//example.com/search?q=Wrong+Host",
        "https://user@www.google.com/search?q=Userinfo",
        "https://www.google.com:444/search?q=Wrong+Port"
      ]

      aggregate_failures do
        invalid_links.each do |href|
          html = artwork_section_page(cards: <<~HTML)
            <div>
              <a href="#{href}">
                <img alt="Invalid Origin" data-src="https://images.example/invalid.jpg">
                <div><div>Invalid Origin</div><div></div></div>
              </a>
            </div>
          HTML

          expect { extract(html) }.to raise_error(
            GoogleSearch::InvalidLink,
            /card 1.*https:\/\/www\.google\.com/i
          )
        end
      end
    end

    it "reports malformed saved image data for an artwork card" do
      scripts = <<~HTML
        <script>
          var s = 'data:image/jpeg;base64,QQ\\xZZ';
          var ii = [ 'artwork-image' ];
          _setImagesSrc(ii, s, r);
        </script>
      HTML
      html = artwork_section_page(cards: <<~HTML, scripts: scripts)
        <div>
          <a href="/search?q=Malformed+Image">
            <img id="artwork-image" alt="Malformed Image" src="#{placeholder_image}">
            <div><div>Malformed Image</div><div></div></div>
          </a>
        </div>
      HTML

      expect { extract(html) }.to raise_error(GoogleSearch::InlineImageSourceError) do |error|
        expect(error.message).to include("artwork-image")
        expect(error.message).not_to include("QQ\\xZZ")
        expect(error.message.length).to be < 200
      end
    end

    it "ignores malformed page-image data before decoding a requested artwork image" do
      scripts = <<~HTML
        <script>
          var s = 'data:image/jpeg;base64,QQ\\xZZ';
          var ii = [ 'page-logo' ];
          _setImagesSrc(ii, s, r);
        </script>
        <script>
          var s = 'data:image/jpeg;base64,QQ\\x3d\\x3d';
          var ii = [ 'artwork-image' ];
          _setImagesSrc(ii, s, r);
        </script>
      HTML
      html = artwork_section_page(cards: <<~HTML, scripts: scripts)
        <div>
          <a href="/search?q=Relevant+Image">
            <img id="artwork-image" alt="Relevant Image" src="#{placeholder_image}">
            <div><div>Relevant Image</div><div></div></div>
          </a>
        </div>
      HTML

      expect(extract(html)).to eq(
        {
          "artworks" => [
            {
              "name" => "Relevant Image",
              "link" => "https://www.google.com/search?q=Relevant+Image",
              "image" => "data:image/jpeg;base64,QQ=="
            }
          ]
        }
      )
    end
  end
end
