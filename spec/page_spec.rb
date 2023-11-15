require "page"

describe Page do
  let(:files_path) { "#{File.join File.dirname(__FILE__), '..'}/files" }

  let :van_gogh_html do
    file = File.read "#{files_path}/van-gogh-paintings.html"
    Nokogiri::HTML file
  end

  let :rembrandt_html do
    file = File.read "#{files_path}/rembrandt-paintings.html"
    Nokogiri::HTML file
  end

  let :van_gogh_expected_result do
    file = File.read "#{files_path}/van-gogh-expected.json"
    JSON.parse file
  end

  let :rembrandt_expected_result do
    file = File.read "#{files_path}/rembrandt-expected.json"
    JSON.parse file
  end

  # Quick & dirty testing. Project ran long due to results format differing from project's
  it "yields the expected array for carousel style results" do
    page = Page.new van_gogh_html
    result = JSON.parse page.as_json
    result["artworks"].each_with_index do |artwork, i|
      artwork.each do |k, v|
        expect(v).to eq(van_gogh_expected_result["artworks"][i][k])
      end
    end
  end

  it "yields the expected array for current style results" do
    page = Page.new rembrandt_html
    result = JSON.parse page.as_json
    result["artworks"].each_with_index do |artwork, i|
      artwork.each do |k, v|
        expect(v).to eq(rembrandt_expected_result["artworks"][i][k])
      end
    end
  end
end
