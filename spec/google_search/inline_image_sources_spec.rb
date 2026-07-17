# frozen_string_literal: true

require "nokolexbor"
require "google_search/inline_image_sources"

RSpec.describe GoogleSearch::InlineImageSources do
  def document_with(*scripts, body: "")
    script_elements = scripts.map { |script| "<script>#{script}</script>" }.join
    Nokolexbor::HTML("<!doctype html><html><head>#{script_elements}</head><body>#{body}</body></html>")
  end

  def sources_for(*scripts, requested_image_ids:)
    described_class.new(document_with(*scripts), requested_image_ids: requested_image_ids)
  end

  it "does not inspect document scripts when no nonblank image IDs are requested" do
    document = instance_double(Nokolexbor::Document)
    expect(document).not_to receive(:css)

    sources = described_class.new(document, requested_image_ids: [ nil, "", "" ])

    expect(sources.to_h).to eq({})
  end

  it "recovers the eight inline artwork images from the supplied page" do
    document = Nokolexbor::HTML(fixture_file("files", "van-gogh-paintings.html"))
    artwork_root = document.at_css('[data-attrid="kc:/visual_art/visual_artist:works"]')
    image_ids = artwork_root.css("img[id]").map { |image| image["id"] }
    expected_images = json_fixture("files", "expected-array.json").fetch("artworks").first(8)
      .map { |artwork| artwork.fetch("image") }

    sources = described_class.new(document, requested_image_ids: image_ids)

    expect(image_ids.length).to eq(8)
    expect(image_ids.map { |id| sources[id] }).to eq(expected_images)
  end

  it "decodes hexadecimal and simple JavaScript string escapes for multiple IDs" do
    script = <<~'JAVASCRIPT'
      var s = 'https:\/\/images.example\/it\'s\\detail\x3fsize\x3dlarge';
      var ii = [ 'first-image', "second-image" ];
      var r = '';
      _setImagesSrc(ii, s, r);
    JAVASCRIPT

    sources = sources_for(script, requested_image_ids: [ "first-image", "second-image" ])

    expect(sources.to_h).to eq(
      {
        "first-image" => "https://images.example/it's\\detail?size=large",
        "second-image" => "https://images.example/it's\\detail?size=large"
      }
    )
  end

  it "preserves large image strings while decoding supported escapes" do
    prefix = "A" * 32_768
    suffix = "B" * 32_768
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,#{prefix}\\x3d#{suffix}\\/end';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    source = sources_for(script, requested_image_ids: [ "artwork-image" ])["artwork-image"]

    expect(source).to eq("data:image/jpeg;base64,#{prefix}=#{suffix}/end")
  end

  it "preserves UTF-8 text and decodes each source escape only once" do
    script = <<~'JAVASCRIPT'
      var s = 'pré\\x3dfixe\x3f後';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    source = sources_for(script, requested_image_ids: [ "artwork-image" ])["artwork-image"]

    expect(source).to eq("pré\\x3dfixe?後")
  end

  it "ignores mappings that do not belong to a requested image ID" do
    malformed_unrelated_script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ\\xZZ';
      var ii = [ 'page-logo' ];
      var r = '';
      _setImagesSrc(ii, s, r);
    JAVASCRIPT
    valid_relevant_script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ\\x3d\\x3d';
      var ii = [ 'artwork-image' ];
      var r = '';
      _setImagesSrc(ii, s, r);
    JAVASCRIPT

    sources = sources_for(
      malformed_unrelated_script,
      valid_relevant_script,
      requested_image_ids: [ "artwork-image" ]
    )

    expect(sources["artwork-image"]).to eq("data:image/jpeg;base64,QQ==")
    expect(sources["page-logo"]).to be_nil
  end

  it "treats characters such as .* in a requested image ID literally" do
    malformed_unrelated_script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,UNRELATED\\xZZ';
      var ii = [ 'artwork-image-other' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT
    valid_relevant_script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ\\x3d\\x3d';
      var ii = [ 'artwork-image.*' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    sources = sources_for(
      malformed_unrelated_script,
      valid_relevant_script,
      requested_image_ids: [ "artwork-image.*" ]
    )

    expect(sources.to_h).to eq("artwork-image.*" => "data:image/jpeg;base64,QQ==")
  end

  it "finds a requested image ID written with hexadecimal escapes" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ\\x3d\\x3d';
      var ii = [ 'artwork\\x2dimage' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    sources = sources_for(script, requested_image_ids: [ "artwork-image" ])

    expect(sources.to_h).to eq("artwork-image" => "data:image/jpeg;base64,QQ==")
  end

  it "keeps a malformed unrelated assignment separate from a requested assignment" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,UNRELATED\\xZZ'
      var ii = [ 'page-logo' ];
      _setImagesSrc(ii, s);

      var s = 'data:image/jpeg;base64,QQ\\x3d\\x3d';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    sources = sources_for(script, requested_image_ids: [ "artwork-image" ])

    expect(sources.to_h).to eq("artwork-image" => "data:image/jpeg;base64,QQ==")
  end

  it "continues after an unrelated mapping with an unsupported ID escape" do
    script = <<~'JAVASCRIPT'
      var s = 'data:image/jpeg;base64,UNRELATED';
      var ii = [ 'page\u002dlogo' ];
      _setImagesSrc(ii, s);

      var s = 'data:image/jpeg;base64,QQ\x3d\x3d';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    sources = sources_for(script, requested_image_ids: [ "artwork-image" ])

    expect(sources.to_h).to eq("artwork-image" => "data:image/jpeg;base64,QQ==")
  end

  it "keeps an unfinished unrelated ID list separate from a requested assignment" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,UNRELATED';
      var ii = [ 'page-logo'
      _setImagesSrc(ii, s);

      var s = 'data:image/jpeg;base64,QQ\\x3d\\x3d';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    sources = sources_for(script, requested_image_ids: [ "artwork-image" ])

    expect(sources.to_h).to eq("artwork-image" => "data:image/jpeg;base64,QQ==")
  end

  it "keeps errors short and excludes malformed image data" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,SECRET-PAYLOAD\\xZZ';
      var ii = [ 'artwork-image' ];
      var r = '';
      _setImagesSrc(ii, s, r);
    JAVASCRIPT

    expect do
      sources_for(script, requested_image_ids: [ "artwork-image" ])
    end.to raise_error(GoogleSearch::InlineImageSourceError) { |error|
      expect(error.message).to include("artwork-image")
      expect(error.message).not_to include("SECRET-PAYLOAD")
      expect(error.message.length).to be < 200
    }
  end

  it "rejects unsupported escapes in a requested image source" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ\\u003d\\u003d';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    expect do
      sources_for(script, requested_image_ids: [ "artwork-image" ])
    end.to raise_error(GoogleSearch::InlineImageSourceError, /artwork-image.*unsupported/i)
  end

  it "checks every requested image assignment and rejects conflicting sources" do
    first_script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ==';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT
    second_script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,Qg==';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    expect do
      sources_for(first_script, second_script, requested_image_ids: [ "artwork-image" ])
    end.to raise_error(GoogleSearch::InlineImageSourceError, /artwork-image.*conflicting/i)
  end

  it "checks every requested image assignment within one script" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ==';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);

      var s = 'data:image/jpeg;base64,Qg==';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    expect do
      sources_for(script, requested_image_ids: [ "artwork-image" ])
    end.to raise_error(GoogleSearch::InlineImageSourceError, /artwork-image.*conflicting/i)
  end

  it "accepts a repeated assignment and returns a copy callers can modify" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ==';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    sources = sources_for(script, script, requested_image_ids: [ "artwork-image" ])
    copy = sources.to_h
    copy.clear

    expect(sources["artwork-image"]).to eq("data:image/jpeg;base64,QQ==")
    expect(sources["missing-image"]).to be_nil
  end

  it "rejects a requested assignment with a missing semicolon" do
    script = <<~JAVASCRIPT
      var s = 'data:image/jpeg;base64,QQ==';
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);

      var s = 'data:image/jpeg;base64,QQ=='
      var ii = [ 'artwork-image' ];
      _setImagesSrc(ii, s);
    JAVASCRIPT

    expect do
      sources_for(script, requested_image_ids: [ "artwork-image" ])
    end.to raise_error(GoogleSearch::InlineImageSourceError, /artwork-image.*malformed/i)
  end

  it "rejects requested loader calls with extra arguments or missing punctuation" do
    malformed_calls = [
      "_setImagesSrc(ii, s, unexpected);",
      "_setImagesSrc(ii, s;"
    ]

    aggregate_failures do
      malformed_calls.each do |call|
        script = <<~JAVASCRIPT
          var s = 'data:image/jpeg;base64,QQ==';
          var ii = [ 'artwork-image' ];
          #{call}
        JAVASCRIPT

        expect do
          sources_for(script, requested_image_ids: [ "artwork-image" ])
        end.to raise_error(GoogleSearch::InlineImageSourceError, /artwork-image.*malformed/i)
      end
    end
  end

  it "rejects malformed assignments whose requested ID uses JavaScript escapes" do
    malformed_mappings = [
      <<~JAVASCRIPT,
        var s = 'data:image/jpeg;base64,QQ\\xZZ';
        var ii = [ 'artwork\\x2dimage' ];
        _setImagesSrc(ii, s);
      JAVASCRIPT
      <<~JAVASCRIPT
        var s = 'data:image/jpeg;base64,QQ==';
        var ii = [ 'artwork\\x2dimage' ];
        _setImagesSrc(ii, s, unexpected);
      JAVASCRIPT
    ]

    aggregate_failures do
      malformed_mappings.each do |script|
        expect do
          sources_for(script, requested_image_ids: [ "artwork-image" ])
        end.to raise_error(GoogleSearch::InlineImageSourceError, /artwork-image.*(?:unsupported|malformed)/i)
      end
    end
  end

  it "rejects malformed element ID lists that name a requested image" do
    malformed_declarations = [
      "var ii = [ 'artwork-image', not_a_string ];",
      "var ii = [ 'artwork-image'",
      "var ii = [ 'artwork-image ];",
      "var ii = [ 'artwork\\x2dimage ];"
    ]

    aggregate_failures do
      malformed_declarations.each do |declaration|
        script = <<~JAVASCRIPT
          var s = 'data:image/jpeg;base64,QQ==';
          #{declaration}
          _setImagesSrc(ii, s);
        JAVASCRIPT

        expect do
          sources_for(script, requested_image_ids: [ "artwork-image" ])
        end.to raise_error(GoogleSearch::InlineImageSourceError, /artwork-image.*malformed/i)
      end
    end
  end

  it "does not interpret image-loader text outside script elements" do
    body = <<~HTML
      <pre>
        var s = 'data:image/jpeg;base64,QQ==';
        var ii = [ 'artwork-image' ];
        _setImagesSrc(ii, s);
      </pre>
    HTML

    sources = described_class.new(document_with(body: body), requested_image_ids: [ "artwork-image" ])

    expect(sources.to_h).to eq({})
  end
end
