# frozen_string_literal: true

RSpec.describe GoogleSearch::ArtworkExtractor, "with additional saved Google page contracts" do
  def extract_fixture(name)
    html = fixture_file("spec", "fixtures", "#{name}.html")
    described_class.new(html).call
  end

  context "with the saved Claude Monet artwork page" do
    let(:result) { extract_fixture("claude-monet-artworks") }
    let(:artworks) { result.fetch("artworks") }

    it "keeps all cards in source order and omits only blank extensions" do
      names = artworks.map { |artwork| artwork.fetch("name") }
      names_without_extensions = artworks.reject { |artwork| artwork.key?("extensions") }
        .map { |artwork| artwork.fetch("name") }

      expect(artworks.length).to eq(50)
      expect([ names.first, names.last ]).to eq([ "Impression, Sunrise", "Le Bassin aux Nymphéas" ])
      expect(names_without_extensions).to eq(
        [
          "Bouquet of Sunflowers",
          "Path in the Wheat at Pourville",
          "Irises",
          "On the Bank of the Seine, Bennecourt"
        ]
      )
    end

    it "uses images already in src and image URLs stored in data-src" do
      images = artworks.map { |artwork| artwork.fetch("image") }

      expect(images.count { |image| image.start_with?("data:image/jpeg;base64,") }).to eq(8)
      expect(images.count { |image| image.start_with?("https://") }).to eq(42)
      expect(artworks.map { |artwork| artwork.fetch("link") }).to all(
        start_with("https://www.google.com/search?")
      )
    end
  end

  context "with the saved Pablo Picasso artwork page" do
    let(:html) { fixture_file("spec", "fixtures", "pablo-picasso-artworks.html") }
    let(:result) { described_class.new(html).call }
    let(:artworks) { result.fetch("artworks") }

    it "records that Artworks was selected when the page was saved" do
      document = Nokolexbor::HTML(html)
      selected_labels = document.css("[aria-current='page']").map { |node| node.text.strip }

      expect(document.at_css("[data-attrid='kc:/visual_art/visual_artist:works']")).not_to be_nil
      expect(selected_labels).to include("Artworks")
    end

    it "keeps all 45 cards in source order and omits only blank extensions" do
      names = artworks.map { |artwork| artwork.fetch("name") }
      names_without_extensions = artworks.reject { |artwork| artwork.key?("extensions") }
        .map { |artwork| artwork.fetch("name") }

      expect(artworks.length).to eq(45)
      expect([ names.first, names.last ]).to eq([ "Guernica", "The Two Saltimbanques" ])
      expect(names_without_extensions).to eq(
        [
          "Tête de Femme",
          "Woman's Head",
          "War and Peace",
          "The Women of Algiers",
          "Weeping Woman with Handkerchief"
        ]
      )
    end

    it "preserves images in src and image URLs stored in data-src" do
      images = artworks.map { |artwork| artwork.fetch("image") }

      expect(images.count { |image| image.start_with?("data:image/jpeg;base64,") }).to eq(8)
      expect(images.count { |image| image.start_with?("https://") }).to eq(37)
      expect(artworks.map { |artwork| artwork.fetch("link") }).to all(
        start_with("https://www.google.com/search?")
      )
    end
  end

  context "with the saved Frida Kahlo artwork page" do
    let(:html) { fixture_file("spec", "fixtures", "frida-kahlo-artworks.html") }
    let(:result) { described_class.new(html).call }
    let(:artworks) { result.fetch("artworks") }

    it "records that Artworks was selected when the page was saved" do
      document = Nokolexbor::HTML(html)
      selected_labels = document.css("[aria-current='page']").map { |node| node.text.strip }

      expect(document.at_css("[data-attrid='kc:/visual_art/visual_artist:works']")).not_to be_nil
      expect(selected_labels).to include("Artworks")
    end

    it "keeps all 49 cards in source order and omits only blank extensions" do
      names = artworks.map { |artwork| artwork.fetch("name") }
      names_without_extensions = artworks.reject { |artwork| artwork.key?("extensions") }
        .map { |artwork| artwork.fetch("name") }

      expect(artworks.length).to eq(49)
      expect([ names.first, names.last ]).to eq(
        [ "Frieda and Diego Rivera", "Self Portrait with Curly Hair" ]
      )
      expect(names_without_extensions).to eq(
        [
          "Self-Portrait as a Tehuana",
          "The Wounded Table",
          "Self Portrait with Stalin"
        ]
      )
    end

    it "keeps placeholder-only cards while omitting their unavailable images" do
      images = artworks.filter_map { |artwork| artwork["image"] }
      names_without_images = artworks.reject { |artwork| artwork.key?("image") }
        .map { |artwork| artwork.fetch("name") }

      expect(images.count { |image| image.start_with?("data:image/jpeg;base64,") }).to eq(6)
      expect(images.count { |image| image.start_with?("https://") }).to eq(41)
      expect(names_without_images).to eq(
        [
          "The Broken Column",
          "Self-Portrait with Thorn Necklace and Hummingbird"
        ]
      )
      expect(artworks.map { |artwork| artwork.fetch("link") }).to all(
        start_with("https://www.google.com/search?")
      )
    end
  end

  context "with the saved Zdzisław Beksiński artwork page" do
    let(:html) { fixture_file("spec", "fixtures", "zdzislaw-beksinski-artworks.html") }
    let(:result) { described_class.new(html).call }
    let(:artworks) { result.fetch("artworks") }

    it "records that Artworks was selected when the page was saved" do
      document = Nokolexbor::HTML(html)
      selected_labels = document.css("[aria-current='page']").map { |node| node.text.strip }

      expect(document.at_css("[data-attrid='kc:/visual_art/visual_artist:works']")).not_to be_nil
      expect(selected_labels).to include("Artworks")
    end

    it "keeps all seven cards in source order while omitting every blank extension" do
      names = artworks.map { |artwork| artwork.fetch("name") }

      expect(artworks.length).to eq(7)
      expect(names).to eq(
        [
          "Krajobraz cmentarny",
          "Untitled \"Stone Islands\"",
          "Untitled \"Loss\"",
          "Untitled \"ZIES\"",
          "Oczekiwanie",
          "Untitled \"Floating\"",
          "Untitled \"Faces\""
        ]
      )
      expect(artworks).to all(satisfy { |artwork| !artwork.key?("extensions") })
    end

    it "preserves all seven images already present in src" do
      images = artworks.map { |artwork| artwork.fetch("image") }

      expect(images).to all(start_with("data:image/jpeg;base64,"))
      expect(artworks.map { |artwork| artwork.fetch("link") }).to all(
        start_with("https://www.google.com/search?")
      )
    end
  end
end
