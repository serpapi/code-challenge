# frozen_string_literal: true

require 'spec_helper'

describe ExtractPaintings do
  context 'with a given Van Gogh example HTML example file' do
    let(:input_html_file) { 'files/van-gogh-paintings.html' }
    let(:expected_array_file) { 'spec/expected-array.txt' }
    let(:complete_json_file) { 'files/van-gogh-paintings.json' }

    it 'returns the expected given output, minimized' do
      expected_output = File.read(expected_array_file)
      # Stripping formatting characters, to compare:
      expected_minimized = JSON.parse("{#{expected_output}}").to_json
      # open('expected_minimized.txt', 'w') {|f| f << expected_minimized  }
      json_output = ExtractPaintings.parse_html(input_html_file, format: :json)
      # ExtractPaintings.parse_html_to_file(json_text: json)
      expect(json_output).to be_a(String)
      expect(json_output).to eq expected_minimized
    end

    it 'matches the ["knowledge_graph"]["artworks"] section of the full API given JSON' do
      json_file_content = File.read(complete_json_file)
      art_array = JSON.parse(json_file_content)['knowledge_graph']['artworks']
      expect(art_array).to be_a(Array)
      array_output = ExtractPaintings.parse_html(input_html_file, format: :array).collect{|h| h.transform_keys(&:to_s)}
      expect(array_output).to be_a(Array)
      expect(art_array).to eq array_output
    end
  end

  context 'raises an Exception if' do
    let(:valid_html_file) { 'files/van-gogh-paintings.html' }
    let(:not_existing_file) { 'not_existing_file.html' }

    it 'the given file does not exist' do
      expect { ExtractPaintings.parse_html(valid_html_file) }.not_to raise_error
      expect { ExtractPaintings.parse_html(not_existing_file) }.to raise_error(RuntimeError, 'File does not exist!')
    end

    it 'the output format requested is not supported' do
      expect { ExtractPaintings.parse_html(valid_html_file, format: :json) }.not_to raise_error
      expect { ExtractPaintings.parse_html(valid_html_file, format: :exotic) }.to raise_error(RuntimeError, 'Unsupported output format!')
    end
  end
end
