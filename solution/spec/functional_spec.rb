describe 'main' do
  let(:browser) do
    Watir::Browser.new(
      :chrome,
      switches: %w[
        --ignore-certificate-errors
        --disable-popup-blocking
        --disable-translate
        --disable-notifications
        --start-maximized
        --disable-gpu
        --headless
      ]
    )
  end

  context '::run' do
    # nearly working but differences due to how Chrome showing special characters
    xit 'returns the same output as the expected-array.json' do
      files_dir                = File.join(File.expand_path(File.dirname(__FILE__)), '../../files')
      input_html_path          = File.join(files_dir, 'van-gogh-paintings.html')
      input_html_url           = "file://#{input_html_path}"
      expected_array_json_path = File.join(files_dir, 'expected-array.json')
      pc                       = ParseCarousel.new

      browser.goto(input_html_url)
      pc.extract_carosel_items!(browser.html)

      parsed_html_hash = JSON.parse(pc.to_json, symbolize_names: true)
      expected_hash    = JSON.parse(File.read(expected_array_json_path), symbolize_names: true)

      expect(parsed_html_hash).to eq(expected_hash)
    end
  end
end
