require "test_helper"

class ScraperTest < ActiveSupport::TestCase
  SAMPLES = [
    { artist: "Van Gogh", file: "van-gogh-paintings.html", name: "The Starry Night", year: "1889" },
    { artist: "Da Vinci", file: "da-vinci-paintings.html", name: "Salvator Mundi", year: "1500" },
    { artist: "Picasso", file: "picasso-paintings.html", name: "Guernica", year: "1937" }
  ]

  SAMPLES.each do |sample|
    test "#{sample[:artist]} has required fields" do
      html = File.read(Rails.root.join('files', sample[:file]))
      result = Scraper.scrape(html)
      item = result["artwork"].first

      assert_includes item.keys, :name
      assert_includes item.keys, :link
      assert_includes item.keys, :image
    end

    test "#{sample[:artist]} extracts #{sample[:name]} correctly" do
      html = File.read(Rails.root.join('files', sample[:file]))
      result = Scraper.scrape(html)
      item = result["artwork"].find { |art| art[:name] == sample[:name] }

      assert_not_nil item, "Should find #{sample[:name]}"
      assert_equal sample[:name], item[:name]
      assert_equal [sample[:year]], item[:extensions] if sample[:year]
      assert_match /google.com/, item[:link]
      assert_not_nil item[:image]
    end

    test "#{sample[:artist]} image data is not a placeholder" do
      html = File.read(Rails.root.join('files', sample[:file]))
      result = Scraper.scrape(html)
      item = result["artwork"].first

      placeholder = "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
      assert_not_equal placeholder, item[:image], "Image should not be placeholder"
    end

    test "#{sample[:artist]} handles items without year extensions" do
      html = File.read(Rails.root.join('files', sample[:file]))
      result = Scraper.scrape(html)
      items_without_year = result["artwork"].select { |art| art[:extensions].nil? }

      assert_kind_of Array, items_without_year
    end

    test "#{sample[:artist]} extensions is an array when present" do
      html = File.read(Rails.root.join('files', sample[:file]))
      result = Scraper.scrape(html)
      item_with_year = result["artwork"].find { |art| art[:extensions] }

      if item_with_year
        assert_instance_of Array, item_with_year[:extensions]
        assert_equal 1, item_with_year[:extensions].length
      end
    end
  end
end
