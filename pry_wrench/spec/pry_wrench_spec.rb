require 'spec_helper'


module PryWrench

  describe PryWrench do
    it 'has a version number' do
      expect(PryWrench::VERSION).not_to be nil
    end

    it 'extracts name, extensions array (date), and Google link in an array' do
      # FIXME: This needs to start at the HTML file
      json_string = File.read('../files/van-gogh-paintings.json')
      result = PryWrench.extract_data(json_string)

      name = result[0]
      extensions = result[1]
      link = result[2]

      expect(name).to eq("TODO")
      expect(extensions).to eq("TODO")
      expect(link).to eq("TODO")
    end

    it 'can extract data from the html' do
      raw_html = File.read('../files/van-gogh-paintings.html')

      result = PryWrench.process_html(raw_html)

      expect(false)
    end



  end

end
