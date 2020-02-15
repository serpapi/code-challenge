require 'rspec'
require 'pry'
require_relative '../lib/artwork_extractor'

describe ArtworkExtractor do

  describe '#extract_data' do
    before(:all) do
      file = File.read('files/van-gogh-paintings.html')
      @data = ArtworkExtractor.new(file).extract_data
    end

    it 'extracts 51 items' do
      expect(@data.size).to eq(51)
    end

    describe 'name extraction' do
      it 'matches the artwork name for the first card' do
        expect(@data.first[:name]).to eq('The Starry Night')
      end

      it 'matches the artwork name for the second card' do
        expect(@data[1][:name]).to eq('Irises')
      end

      it 'matches the artwork name for the last card' do
        expect(@data.last[:name]).to eq('Portrait of Adeline Ravoux')
      end
    end

    describe 'link extraction' do
      it 'extracts the first link from the card' do
        expect(@data.first[:link]).to eq('https://www.google.com/search?gl=us&hl=en&q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhUIyUhVCC5JLCqqVPDLTM8oAQDmNFnDqgAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYILw')
      end

      it 'extracts the second link from the card' do
        expect(@data[1][:link]).to eq('https://www.google.com/search?gl=us&hl=en&q=Irises+(painting)&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLGMzUvMi7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YI7kFXv64JywVMGnNyWuMXlxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF5_EsYhX0LMosTi1W0ChIzASqz0vXBADZ_49eqwAAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIMg')
      end
    end

    describe 'image extraction' do

      # FIXME: this should return 8 but is returning 5
      xit 'extracts 8 images' do
        expect(@data.map { |item| item[:image] }.compact.size).to eq(8)
      end

      it 'extracts the image for the first card in base64 format' do
        expect(@data.first[:image]).to eq("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAHgAeAMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAAEAAIDBQYBB//EADkQAAIBAwMBBgQEBQQCAwAAAAECAwAEERIhMQUTIkFRYXEygZGhscHR8AYUUuHxFSNCYkOiM3KS/8QAGgEAAwEBAQEAAAAAAAAAAAAAAQIDAAQFBv/EACQRAAICAgICAgIDAAAAAAAAAAABAhEDIRIxBFEiQRNhBRRS/9oADAMBAAIRAxEAPwCa4tIZIx2qCTOCVYAgn29MVget262/UJ1tyUjJDMmnGTjfb3JrQy9clKEdm6lSCADs2PM52+9Z+9lkKz3Mrs8hyQ2rJG3HNdnjePLFFvI7IOVvRadHezawC3c0bkbt23huePtVLKjQXOuE64A/dddxz4GorONzbq3ZF8blufGiSUkjIkUbbjAUY+emr48d/NPsD9Go6JCotVmZO+4OAfAHHnx9abfWcdy6rBhJZM9/w25zjk+1VCXciRLHbvIjLgomRpbB8gBn6UxOo3kMyzSyws39LDAHnileCam5pgtBslnNZKss7A99d4zyPLff86b/AKhGgkMgiQHdnLZOfJd8jf0FCXnVru7TTqUJn4YufTeo5HDRqz76RpEaAah6k02PHJxTydmb3oT3BZdIlYgnlsg//r+1ExdGmliSUB9xq1J4+ONzVdbFJpcsndDA8ncfj+Nbm3uIFhUR4CAYX9aXycjxw+KsKWzLfyBs5lZw5UnfLHCH1Gd/wqOWFGeRBLJ2svdXAP4cCtB1WaN7R8MBsSO73s42rLi7E7FgcLGmFHBH73oYZ84XJUwPsORws6wRavh2K7/M+tTWuFlaITPGw7xZmzkY2x+/aoelwAnUr65SNAz4bZP5fWtD0vpK/wAytwxDEYwCePTHyH7FPkfGNsWwOCw6ncEkFez2BLaiD9CB8qVbO1gVGORojXhVG1KvHy/yajKki0cMmrPMdHacEjxI4oO8XTaT+PdK7ZOPrRUnbQytHcQsqAbtyufahLlHNvIgQkFCRtvgb17uSXLG2RjqRr+gWcCdOgDbuYxweSfzqr/iS1RZ0fUMsD57gHx29TXOmm9ktImhcaGUEZUEf2HvRMnTppZtdxMJGbdVXw+fA/fNefg8eWPN+VyteikppqqKeO3du6iALyWB3qztunxuyjs8u3/QYHv51ZSWvZks3O2B5fP6frUkTJZR9tcXAiRx8OSua6cmb0TSBW6CmomR4IweVGxNOl6ArQ7OjBBkqF3H1xQbXgnZ2UJKmdsID+NSw3IaYJ2IRAN8rpA+h2z58VNLJ2xk4/QGOivPDoFwv9QwM7eRB3pjR3vTISdWYg2dad76jG49qtJUEkAng1kDIaMN3kYHGzbHHoakgu0uLcwOW7uW7M/E48cev6jHjVuTrYtlA7G8XZz32DfFuds7ffY+VFr0d2MeOzUEZbVyM/5potxZ9Y1g/wCzrzkD5/v3rZW7Wkg0thjpOkefzqWbPLFVIaMUzH29o9rOySgaQdRG+R4ceP8AatZ0BC+C7A4AO4xtz+VVfVYSukRk6gdgB7ZHtUnSeomBcZJjVwHXHgQf2fWjnvLg12ItS2am6OlVXGFwT7nNKm280V5aqAxOf+TDBB9R512vjPJwZfyM9TFkjxMyzB2ES6JFHCkd7jz8aCu2it7OeaYRRBNWyrgsfWrGGxt4WLJDFH5BNj9OKy/XLxXtOoWzMS6XZxvyDv8ArX2EpcVo86Ktjf4Ku2MV1a6EbsiHjEgyFzzWmjfs0kMQLDGM8jPPlish/CM6Ws91NoLsUUKgIBJ+dFdV6tcSS28Eg0xFd4o9JGd9zv4D+5pcS+CNLs1MdrM0Bn2LEf8APgH1HjyKysdpL1O+lnvZGdEJHuccemAOPE1Zr1omEW6qXfScnO3uT4neiLS1Mqhy+H3bI4zx+P2p4KavmLr6Gx2EDnR2IYEYQ5xj19M5H2pG3ETdlLvGoIwzZIPGD6fp7U+btEbUoIyeR6cH6ioWuzdxW8ukdp8W5G+Ofoc/WqK0wOieGGS2uFhjPdJGQO9qwAR/65HyFK86fK9uNJUyRM2lgcbYOn6nArtrLFlS2SCDnU2l1PBGPwxUt7dPChWCF3ZthtsDzn1xtW+9GKQzme4l1Nqkj0OcD/iw2+dTxX86xkI5zjGQd1x+/SpIOnFi620aaiAJGL7DBOB68713/S7uANpgyuCTpz9hTc49SNTe0SmYmPtCJDpydZBP2oa2GiVplkJR8klCcqPMef8AauNG5ibV2ZXwIGN/nREUKhC+AxyDlfD5Uya6+hOizsepNbwpFCoYL/5CdWcn1P50qroo5P8Axxqp3PJ3/fvSqb8XDJ20HnL2T2bX13GQNAA5ODtWJ6/HNb9UuFnY6icn1B4rf9Hv47QOsugd7zyG2rE/xlcxXPVnKZ7ihM+3+ftXDlnP8ji1o6MaVFd02Zkugq7hiF0k7bmr2G1e5WSV4lDBtIYryBxn+reszb5W4iYHBLDB8j51vOnW57QDWTrbLFj3m4zueec+VW8d/F30Ll10C2fS7howgfWoOWLnAHoM/hV1As1sCHV0A3UZ+LfcfTNaOC3VBh408TjwOP38q60ULrrkC9nyCTqHv9qH9yLfEH4n2ZrPeB1F4/iAUbjPII++1V91ZoGmFu7pqw2Qmyt4kHwqPqjS2k7RI51JuGVCVcfLkeNT/wAw9xZCe30l0+Ju8vyIIH3rpqnaJkGjqawgSOABsHjJOfdT4/apIkSA9rNJLq5Yls5/vUZu7qYCJFWIA94xsMMffgUyOYS9tFodpRsJCc4Pjjfajx/0aywW4uA4FmQFK4ICk48KGUXcGgQEKy4JC+HhnA9xRfT5wbcoqhGICls8eZ+9SxpIkpmdMnf4TkEelLpWG2K+cH/clA72zDxLD9KDte4VVRtwCDg0uo3DGIxqhlnlk+FeT7VfdE6f/LRxmXvSkZYMvw44x89z7YpZZVCFm42zlv0XWRJdqHbHwbd33rlWM0hhVsthNz3jucefoKVcyy5Xux+MFpmCVJ453juEKMwzgDYjz86yV4ddzPgknWxGfHfP4V6nfrbywguVXfY+R5xXlfUlEfUbgb6e0JGTvjJxT5snOKDiVNkMT4ILcrvWxhuQk4bt8qBrYYyMYyM4rGoGJ2GFOT96tRelbWVUyBmOPHgQu5z6HH3qWKVWh5xs9esphNCmOABxvzvxTrmW3ghdXYafhGOF9+KyfSZO2tIHgu5BFjKpGQNOeRxzmrFjDC3azPI7ruHc6sH0H50Hjina2Dk+ivuA01yrxwO4bABdcg+2RUf+myyTuwgiBzkBsZAoyTqUTQsy5IIJORjH44psd0Z8lmihXG3iT7+fyxV1kyJdEmogk1lNNMIYkCvxq/4j5/LijV6Crg95hJkZK7cVxeoIXXSjbtgl38PPYfYeW5FUl11sCXW1y8smgERIpOgZ4zsv1+/NG8sv0bijR2VpCupJtWMkZxz9ac/Tul9qBG0+T/x1Ft/Sso38S9QdT2cMMaDgSksT+A/GuW/8X3alxeQQSAg6dAZcHzIOQaHGa7YyXo2FutlCS0TAyg4yeQv4fSpnv0OjstU0mcAKvA8/L2zWLuevuINaXCOdOwVOPqTVXP1Hq14i4kmG24jbCgeXOMnxoPFb3syTNr1a+itILia6lQXKqWWAyYyQNlA5OT6ZrlYfp/TZpwC4ECZOcAZJ9MfifOlVY4JUFuK7NaJmicI7G3LZ0g7qf/buj0OcedYz+JYVHWJWUkqwBJxvxvTJJppFZ9QA8kGM/M/lQrHWruWOMaNzzUs0otUhscaIoGxHhz8Tc/KpYXV4JItg/wAaep8fsT9KHYav+oY++MVwd46uNIGofv0rmKlj0vqc3TrljDIVifaRSNS588eYq+XrPaRZnm7dsZGnw9MeHzrKZ8wM+PyqeIFgF16EO5Hh5eR8vvVsU+LonOKZczdUvS2q2ZY1HwgDUR8z+WKltOrNJG73dmpmB/8AljRRq/8At+maprO3eaUiNwgU7Fthn9atu1jERFzC3aIMakIGf3jmujnH0TaXRObu6u2AkYxRAfApyx+fh8vrUc0QRnAxj8TmoFkhVSwOARrCNzn38qNnhsnae41pIpk0hw+BwP706yJUaitklEoARV1k76Nz/auJYRrJ2l1pH/UHP1NHvHFAWIAVWGBpB+xoVniRNPY3GknOojn9BuaDnFdmT0GiCKMKHA52K8AHj25wKkAZGMYt2VcZzo29vf09KBifp7Rf7ly5xjUnGePHfz+xonsbMW7XAuZFZsKqF9Wv0yRk8/egs876Nx9hth35mibSoA7pfAVuTsfYH6GlQlvreWKTKa1bC6yCN8/r70qDzTvZqRS3aAJ8/M52FAzMAunGwY5+9Wl65/l3ieKMuDkMg0n2x7f4qocZkyAc87b1xykpPRddEhbVEpYbHPhucHmma2b/AG+SQPHnkfpTQTttqzsMnx4/KlGQGww29OfSlCd2AIByRsT5+WK6GwhB2yefIVxhiYgkY52GOM1zUvYYGNYbBI8t96K7MWK3QiYrGzxIQDiMDC+2BtRFiZZpzLNAbq3XWZFZxuQC2DxvgedVEblY9LhWU7b+H7zU6LGmXKMNWCSD50/N+xa/RdwrFcT9g8XdEyjVCxPZsVzgemnI91FASmKSaZ8GKD+YZchgWXYEDfbj86dbra2jJNHemC4XfCsg3xxufxqGKKW7jjDJLIg/qcAbDOcexoqSjtmqx/8AqKwKsakMyP3pCxOrfIP0qVBeSaVKRxq41AqFBIPhzt/iq2eBjIG0MgZs9xCVPoCB/mmCIsR27Oq/1svjTc3fYOCLNooZY1cTW0U2BlXdSSRnJI2yOPGoEnETFSqOFbIkCnDHgn2oqzZrKI4lZcnSNQBJONsbetE2rJ2zDqsyadI0NIDpG5PgRvv9qNtA02ds7uG5iPaMqO22RGDgevj+XvSoO7FibtY1mZv9xlPYkmNV8CMk5+dKty9g4k8q3EhPaW8ocryqHcc/rQN50+WCPW1vMhGS2pDx5+1KlXHyqVIpQFChnPYLhSCcE+dRxKc94HvZO4O1KlVDMYUcsvdbJ8xzXTG6gawQMDHmM0qVYYkVdYGlW+HHw8n9mrKKNezVHj0vwRpHPrnxpUq0ewSWhdkqvktjffESGuJ/MtOscQOVPZjQSAwxt9gKVKmZkFJLMqK/8u3Zl+yXS22rOPx/AVJEtvqDXMsZMikdmTvgnx289/alSrR7MNube1SREhVQrZLMikuqrvsSPb70DPgNJG7ElSVZm8N8ZpUqopNMWrJV6jdLAhNsGUDAcqDkUqVKspsbgj//2Q\\x3d\\x3d")
      end

      it 'extracts the image for the 8th card in base64 format' do
        expect(@data[7][:image]).to eq("data:image/jpeg;base64,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\\x3d")
      end

      it 'returns a nil image for the 10th card' do
        expect(@data[9][:image]).to be_nil
      end
    end

    describe 'extensions extraction' do
      it 'matches the extensions from the first card' do
        expect(@data.first[:extensions]).to eq(['1889'])
      end

      it 'matches the extensions from the first card' do
        expect(@data.last[:extensions]).to eq(['1890'])
      end
    end

    it 'matches the last item correctly' do
      last_item =   {
        "name": "Portrait of Adeline Ravoux",
        "extensions": [
          "1890"
        ],
        "link": "https://www.google.com/search?gl=us&hl=en&q=Portrait+of+Adeline+Ravoux&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLi1k_XNzQyyjYzTq7SUspOttIvyywuTcyJTywqQWJmFpdYlecXZRc_YozkFnj5456wVMCkNSevMXpxEaFJSIWLzTWvJLOkUkiKi0cKbrsGgxQXF5zHs4hVKiC_qKQoMbNEIT9NwTElNSczL1UhKLEsv7QCAOSAHzG2AAAA&npsic=0&sa=X&ved=0ahUKEwiL2_Hon4_hAhXNZt4KHTOAACwQ-BYIxQE",
        "image": nil
      }
      expect(@data.last).to eq(last_item)
    end

  end

end