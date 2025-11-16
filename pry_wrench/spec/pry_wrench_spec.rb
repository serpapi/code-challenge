require 'spec_helper'


module PryWrench

  describe PryWrench do
    it 'has a version number' do
      expect(PryWrench::VERSION).not_to be nil
    end

    it 'can extract data from the html' do
      raw_html = File.read('../files/van-gogh-paintings.html')

      results = PryWrench.process_html(raw_html)

      expect(results.count).to eq 47

      result = results[0]
      name = result[0]
      extensions = result[1]
      link = result[2]

      expect(name).to eq("The Starry Night")
      expect(extensions).to eq(["1889"])
      expect(link).to eq("https://google.com/search?sca_esv=c2e426814f4d07e9&gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxYtYBUIyUhWCSxKLiioV_DLTM0oAdKX0-E4AAAA&sa=X&ved=2ahUKEwjK-K-JwLWKAxXcQTABHePpOFoQtq8DegQIMxAD")
    end

  end

end
