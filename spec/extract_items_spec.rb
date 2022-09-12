require 'rspec'
require 'nokogiri'
require 'byebug'
require_relative '../app/extract_items'

describe ExtractItems do
  describe '#run' do
    let(:html_file) do
      File.open('spec/fixtures/search_results.html')
    end

    let(:output_file_path) { 'spec/fixtures/search_results.json' }

    subject do
      ExtractItems.new(html_file).run
    end

    before { File.delete(output_file_path) if File.exists?(output_file_path) }

    it 'creates json file' do
      expect { subject }.to change {
        File.exists?(output_file_path)
      }.from(false).to(true)
    end

    it 'outputs expected data' do
      subject

      output_data = JSON.parse(File.read(output_file_path))

      expect(output_data).to eq(
        {
          'artworks' => [
            {
              "name" => "The Starry Night",
              "extensions" => ["1889"],
              "link" => "/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw",
              "image" => "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
            }
          ]
        }
      )
    end
  end
end