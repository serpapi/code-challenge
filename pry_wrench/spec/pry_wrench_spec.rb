require 'spec_helper'


module PryWrench

  describe PryWrench do
    it 'has a version number' do
      expect(PryWrench::VERSION).not_to be nil
    end

    it 'extracts name, extensions array (date), and Google link in an array', current: true do
      json_string = File.read('spec/data/sample_data.json')

      result = PryWrench.extract_data(json_string)

      name = result[0]
      extensions = result[1]
      link = result[2]

      expect(name).to eq("TODO")
      expect(extensions).to eq("TODO")
      expect(link).to eq("TODO")
    end
  end

end
