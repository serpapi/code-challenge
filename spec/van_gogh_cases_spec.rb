# frozen_string_literal: true

RSpec.describe 'Runner results for Van Gogh carousel' do
  # In practice I'd structure this differently, but since this is just an exercise I am keeping as is.

  subject { Runner.new(input_file_url, output_path).run }

  let(:output_path) do
    project_root = File.expand_path('../', __dir__)
    _output_path = File.join(project_root, 'van-gough-output.json')
  end

  let(:input_file_url) do
    spec_root = File.expand_path(__dir__)
    file_path = File.join(spec_root, 'fixtures/pages/van-gogh-paintings.html')

    _file_url = "file:///#{file_path}"
  end

  let(:expected_result) do
    spec_root = File.expand_path(__dir__)
    file_path = File.join(spec_root, 'fixtures/expected/van-gogh-results.json')

    expected_result_file = File.read(file_path)
    _expected_results = JSON.parse(expected_result_file)
  end

  it 'parses and returns json' do
    result_json = JSON.parse(subject)

    expect(result_json).to be_a(Hash)
    expect(result_json).to include('artworks')
    expect(result_json['artworks']).not_to be_empty
  end

  it 'produces the expected results' do
    result_json = JSON.parse(subject)
    result_artworks = result_json['artworks']

    expect(result_artworks).to eq(expected_result['artworks'])
  end
end
