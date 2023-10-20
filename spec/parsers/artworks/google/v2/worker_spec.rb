# frozen_string_literal: true

require 'spec_helper'

describe Parser::Artworks::Google::V2::Worker do
  let(:version) { 'v2' }

  context 'when output is a json format' do
    let(:output) { Parser::Output::Json.new }

    context 'when data inputs from a file' do
      subject(:worker) do
        JSON.parse(described_class.new(input: input, output: output).call)
      end

      context 'when there is a dali painter' do
        it_behaves_like 'a correct parser' do
          let(:painter) { 'dali' }
          let(:expected_name) { 'The Persistence of Memory' }
          let(:expected_extensions) { ['1931'] }
          let(:expected_link) do
            'https://google.com/search?sca_esv=575117049&q=The+'\
          'Persistence+of+Memory&stick=H4sIAAAAAAAAAONgFuLQz9U3sIyvyFPiBLGMDNIsqrSUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZ'\
          'xYtYJUMyUhUCUouKgWKpecmpCvlpCr6puflFlQDGSb20VwAAAA&sa=X&ved=2ahUKEwij5srQkYSCAxVzMlkFHYhtC2oQtq8DegQILhAD'
          end
        end
      end

      context 'when there is a picasso painter' do
        it_behaves_like 'a correct parser' do
          let(:painter) { 'picasso' }
          let(:expected_name) { 'Guernica' }
          let(:expected_extensions) { ['1937'] }
          let(:expected_link) do
            'https://google.com/search?sca_esv=575117049&q=Guernica+(Picasso)&stick=H'\
          '4sIAAAAAAAAAONgFuLQz9U3MDOIN1fiBLFMjAxzTLWUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYhdxLU4vyMpMTFTQCgGRxcb4mA'\
          'C4Q9W5QAAAA&sa=X&ved=2ahUKEwitstv_mISCAxUCLFkFHe-QCpAQtq8DegQIKBAD'
          end
        end
      end
    end
  end
end
