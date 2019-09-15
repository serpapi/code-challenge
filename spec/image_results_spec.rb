require "json"
require_relative "../lib/image_results"

EXAMPLES_DIRECTORY = File.expand_path(File.join(File.dirname(__FILE__), "../files"))

def load_example(name)
  results = ImageResults.new(File.join(EXAMPLES_DIRECTORY, name))

  # Round trip the JSON structure
  @json = JSON.parse(JSON.dump(results.as_json))
end

describe ImageResults do
  shared_context "Basic Behaviors" do
    it "contains the correct number of entries" do
      expect(@json["artworks"].size).to eq(result_count)
    end

    it "contains all known names" do
      subset = @json["artworks"].first(known_names.size)
      subset.zip(known_names).each do |candidate, known|
        expect(candidate["name"]).to eq(known)
      end
    end

    it "contains all known links" do
      subset = @json["artworks"].first(known_links.size)
      subset.zip(known_links).each do |candidate, known|
        expect(candidate["link"]).to start_with(known)
      end
    end

    it "contains all known extensions" do
      subset = @json["artworks"].first(known_extensions.size)
      subset.zip(known_extensions).each do |candidate, known|
        expect(Array(candidate["extensions"]).first).to eq(known)
      end
    end

    it "contains all known images" do
      # These check the END of a known data: URL, where it's unique.
      subset = @json["artworks"].first(known_images.size)
      subset.zip(known_images).each do |candidate, known|
        expect(candidate["image"]).to end_with(known)
      end
    end

    it "contains images that are either `data:` URLs or null" do
      # Note: this fails if chromedriver isn't in headless mode: G is doing something
      # fancy with element visibility, and it gets a real https:// URL
      @json["artworks"].each do |result|
        expect(result["image"]).to satisfy { |v| v.nil? || v.match(/\Adata:/)}
      end
    end

    it "does not generate an empty `extensions` array" do
      @json["artworks"].each do |result|
        expect(result["extensions"]).to satisfy { |v| v.nil? || v.is_a?(Array) }
      end
    end

    it "returns a null image on deferred image loads" do
      # "Reasonably large enough collection enough to have some deferred images"
      if @json["artworks"].size > 10
        expect(@json["artworks"].last["image"]).to be_nil
      end
    end
  end


  describe "Van Gogh Example" do
    include_context "Basic Behaviors"

    before :all do
      @json = load_example("van-gogh-paintings.html")
    end

    let(:result_count) { 51 }

    let(:known_names) do
      ["The Starry Night", "Irises", "Sunflowers", "Van Gogh self-portrait"]
    end

    let(:known_links) do
      [ "https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAA",
        "https://www.google.com/search?gl=us&hl=en&q=Irises+(painting)&stick=H4sIAAAAA",
        "https://www.google.com/search?gl=us&hl=en&q=vase+with+12+sunflowers&stick=H4s" ]
    end

    let(:known_images) do
      [ "VZm8N8ZpUqopNMWrJV6jdLAhNsGUDAcqDkUqVKspsbgj//2Q==",
        "GIqAYVErNQ0z+KFyhLeOJmFh6Eb/XExMTCHNk+Yx8dG3P/2Q==",
        "ozkfPP+K1BJ5B8qlSpVUkxuel1RiOCcZBxUqVKspoakmE//9k=" ]
    end

    let(:known_extensions) do
      [ "1889", "1889", nil, "1889" ]
    end
  end


  describe "Jackson Pollock Example" do
    include_context "Basic Behaviors"

    before :all do
      @json = load_example("jackson-pollock-paintings.html")
    end

    let(:result_count) { 50 }

    let(:known_names) do
      [ "Mural", "Autumn Rhythm (Number 30)", "One: Number 31, 1950" ]
    end

    let(:known_links) do
      [ "https://www.google.com/search?q=Mural+(1943)&stick=H4sIAAAAAAAAAONgFuLQz9U3MD",
        "https://www.google.com/search?q=Autumn+Rhythm&stick=H4sIAAAAAAAAAONgFuLQz9U3M" ]
    end


    let(:known_images) do
      [ "TExtV2h953lPyX6D7SRNUXAEoUgXutI8k87YmJiYdqJMHPM//Z",
        "Jh4IfDckjtqNSbgIGLBnIBGs7ckb32H7YmJiY3DD4bkkf/2Q==",
        "3BI84mJi1YVtSVWa9aqWm+XFL6kikNip8nx287Y9xMTD2JH//Z" ]
    end

    let(:known_extensions) do
      [ "1943", "1950", "1950", "1950" ]
    end
  end


  describe "Andy Warhol Example" do
    include_context "Basic Behaviors"

    before :all do
      @json = load_example("andy-warhol-paintings.html")
    end

    let(:result_count) { 50 }

    let(:known_names) do
      [ "Shot Marilyns", "Marilyn Diptych", "Campbell's Soup Cans" ]
    end

    let(:known_links) do
      [ "https://www.google.com/search?q=Shot+Marilyns&stick=H4sIAAAAAAAAAONgFmLXz9U3y",
        "https://www.google.com/search?q=Marilyn+Diptych&stick=H4sIAAAAAAAAAONgFmLXz9U" ]
    end

    let(:known_images) do
      [ "eRZazAqGWl7TtNidPkjdLf0ynv/wA1PqMLAm60E1uyd5H7L//Z",
        "7NXfur/wAtLS0RI5DgEvvmL+y15/wr/wAtLS0tDrOU4hf/2Q==",
        "mJhqT6HOFcgenrVjy6GNZNMillcFSLAk8jbExMTC3spY0f/9k=" ]
    end

    let(:known_extensions) do
      [ "1964", "1962", "1962", "1963" ]
    end
  end
end
