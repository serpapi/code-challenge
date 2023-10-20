# frozen_string_literal: true

require 'spec_helper'

describe Parser::Artworks::Google::V1::Worker do
  let(:version) { 'v1' }

  context 'when output is a json format' do
    let(:output) { Parser::Output::Json.new }

    context 'when data inputs from a file' do
      subject(:worker) do
        JSON.parse(described_class.new(input: input, output: output).call)
      end

      context 'when there is a van-gogh painter' do
        it_behaves_like 'a correct parser' do
          let(:painter) { 'van-gogh' }
          let(:expected_name) { 'The Starry Night' }
          let(:expected_extensions) { ['1889'] }
          let(:expected_link) do
            'https://google.com/search?gl=us&hl=en&q=The+Starry+'\
          'Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVM'\
          'GnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0a'\
          'hUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw'
          end
        end
      end
    end
  end
end
