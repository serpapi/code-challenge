require 'spec_helper'


module PryWrench

  describe PryWrench do
    it 'has a version number' do
      expect(PryWrench::VERSION).not_to be nil
    end

    it 'does something useful', current: true do
      result = PryWrench.main
      expect(result).to eq("test")
    end
  end

end
