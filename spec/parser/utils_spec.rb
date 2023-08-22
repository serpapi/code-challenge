# frozen_string_literal: true

RSpec.describe Utils do
  describe '.get_base_url' do
    let(:page) { double(css: base_tags) }

    subject { Utils.get_base_url(page) }

    context 'when base tags did not found' do
      let(:base_tags) { [] }

      it { is_expected.to be(nil) }
    end

    context 'when base tag has empty href' do
      let(:base_tags) { [{ 'href' => '' }] }

      it { is_expected.to be(nil) }
    end

    context 'when base tag has not href' do
      let(:base_tags) { [{}] }

      it { is_expected.to be(nil) }
    end

    context 'when base tag has href' do
      let(:base_tags) { [{ 'href' => 'https://google.com/' }] }

      it { is_expected.to eq('https://google.com/') }
    end
  end

  describe '.add_host' do
    let(:url) { '/search?' }

    subject { Utils.add_host(url, params) }

    context 'when there is not base_url for parsed page' do
      let(:params) { {} }

      it { is_expected.to eq(url) }
    end

    context 'when there is base_url for parsed page' do
      let(:params) { { base_url: 'https://google.com/' } }

      it { is_expected.to eq('https://google.com/search?') }

      context 'and url is not relative' do
        let(:url) { 'https://google.com/search' }

        it { is_expected.to eq(url) }
      end
    end
  end
end
