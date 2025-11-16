require 'spec_helper'


# This file ends in _int because it's an integration test and can use the file
# system and network to assert the applications correctness

module PryWrench

  describe PryWrench do
    it 'does something useful' do
      result = PryWrench.main
      expect(result).to eq("test")
    end
  end

end
