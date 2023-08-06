# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagAttributeService do
  subject { TagAttributeService.new }

  let(:html_with_quotes) {
    "<div test-attribute-1='test1' test-attribute-2='test2'><span>Test Title</span></div>"
  }
  let(:html_with_double_quotes) {
    '<div test-attribute-1="test1" test-attribute-2="test2"><span>Test Title</span></div>'
  }

  describe '#get_attribute_value' do
    it 'success (html_with_quotes)' do
      expect(subject.get_attribute_value(html_with_quotes, 'test-attribute-1')).to eq('test1')
      expect(subject.get_attribute_value(html_with_quotes, 'test-attribute-2')).to eq('test2')
    end

    it 'success (html_with_double_quotes)' do
      expect(subject.get_attribute_value(html_with_double_quotes, 'test-attribute-1')).to eq('test1')
      expect(subject.get_attribute_value(html_with_double_quotes, 'test-attribute-2')).to eq('test2')
    end
  end
end