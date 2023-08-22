# frozen_string_literal: true

RSpec.describe Parser::Verifier do
  let(:verifier) { described_class.new(data, expected_data) }

  subject(:is_valid?) { verifier.valid? }

  context 'when input is not parser response' do
    let(:data) { {} }
    let(:expected_data) { {} }

    # TODO: extract into shared_examples
    it { is_expected.to be(false) }

    it 'tells the reason of being invalid' do
      expect(verifier.verify).to be_instance_of(Parser::Verifier::Invalid)
    end
  end

  context 'when input is parser error' do
    let(:data) { Parser::Error.new(StandardError.new('failure')) }
    let(:expected_data) { {} }

    it { is_expected.to be(false) }

    it 'tells the reason of being invalid' do
      expect(verifier.verify).to be_instance_of(Parser::Verifier::Invalid)
    end
  end

  context 'when parser response is the same as expected data' do
    let(:data) { Parser::Response.new({ artworks: [{ name: 'artwork 1' }] }) }
    let(:expected_data) { { artworks: [{ name: 'artwork 1' }] } }

    it { is_expected.to be(true) }
  end

  context 'when parser response is the same as expected data' do
    let(:data) { Parser::Response.new({ artworks: [{ name: 'artwork 1' }] }) }
    let(:expected_data) { { artworks: [{ name: 'artwork 2' }] } }

    it { is_expected.to be(false) }

    it 'returns data changes' do
      verification = verifier.verify

      expect(verification).to be_instance_of(Parser::Verifier::Verification)
      expect(verification.valid?).to be(false)
      expect(verification.diff).to eq([['-', 'artworks[0]', { name: 'artwork 1' }],
                                       ['+', 'artworks[0]', { name: 'artwork 2' }]])
    end
  end
end
