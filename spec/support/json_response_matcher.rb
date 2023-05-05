RSpec::Matchers.define :match_json_response do |response|
  match do |json|
    responses_directory = "#{Dir.pwd}/spec/support/responses"
    response_path = "#{responses_directory}/#{response}.json"
    expected_response = JSON.parse(File.read(response_path))

    expect(JSON.parse(json)).to eq(expected_response)
  end
end
