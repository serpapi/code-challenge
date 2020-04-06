# typed: false
# frozen_string_literal: true

require "./src/google_search_carousel"

RSpec.describe "GoogleSearchCarousel" do
  describe "#extract" do
    context "when given a page without a carousel" do
      it "returns an empty array" do
        items = GoogleSearchCarousel.new(IO.read("spec/files/summary-of-the-bell-jar.html")).extract
        expect(items).to be_empty
      end
    end

    context "when given a page with a sortable/filterable carousel" do
      let(:items) { GoogleSearchCarousel.new(IO.read("spec/files/van-gogh-paintings.html")).extract }

      it "should have multiple items" do
        expect(items.size).to eq(49)
      end

      it "should extract names" do
        expect(items.first.name).to eq("The Starry Night")
        expect(items.last.name).to eq("Self-Portrait with Grey Felt Hat")
      end

      it "should extract links" do
        expect(items.first.link).to eq("https://www.google.com/search?q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YY7kFXv64JywVMmnNyWuMflxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF51kxaTDxLGIVCMlIVQguSSwqqlTwy0zPKAEANpnPwK4AAAA&npsic=0&sa=X&ved=2ahUKEwj4uYjEgM_oAhUZ4zgGHZEcCUcQ-BYwKnoECCIQLA")
        expect(items.last.link).to eq("https://www.google.com/search?q=Self-Portrait+with+Grey+Felt+Hat&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMiw1MTdO1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGGO5BV7-uCcsFTJpzclrjH5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBedZMWkw8SxiVQhOzUnTDcgvKilKzCxRKM8syVBwL0qtVHBLzSlR8EgsAQDCsHEmvwAAAA&npsic=0&sa=X&ved=2ahUKEwj4uYjEgM_oAhUZ4zgGHZEcCUcQ-BYwWnoFCCIQvAE")
      end

      it "should extract optional extensions" do
        expect(items.first.extensions).to eq(["1889"])
        expect(items[14].extensions).to eq([])
        expect(items.last.extensions).to eq(["1887"])
      end

      it "should extract optional images" do
        expect(items.first.image).to eq("data:image/jpeg;base64,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\\x3d")
        expect(items.last.image).to eq(nil)
      end
    end

    context "when given a page with a grid carousel" do
      let(:items) { GoogleSearchCarousel.new(IO.read("spec/files/nobel-prize-winners.html")).extract }

      it "should have multiple items" do
        expect(items.size).to eq(14)
      end

      it "should extract names" do
        expect(items.first.name).to eq("Peter Handke")
        expect(items.last.name).to eq("Esther Duflo")
      end

      it "should extract links" do
        expect(items.first.link).to eq("https://www.google.com/search?q=peter+handke&stick=H4sIAAAAAAAAAONgFuLQz9U3MLWsMFSCsOIrDLSUs5Ot9BPLE4tSIKRVbn5xiUJRanJqXolCeWZeXmpR8SPGHYzcAi9_3BOWWsc4ac3Ja4zLGbmI0SikwsXmmleSWVIpJMXFIwW3X4NBiosL4ZowI69dl6adY3MRLOhkYPjAFeogJaIkxMXuWeyTn5yYI8gABh_slRQ59autFmR1vrcX_Kryv146ytVBgkWBQYPBsKeJkeF6somDFkPTvhWH2Fg4GAUYrJg0mHgWsfIUpJakFilkJOalZKcCAAeO7CUGAQAA&sa=X&ved=2ahUKEwigpNzh0NDoAhUJ6XMBHbCICCsQri4wInoECBUQJw")
        expect(items.last.link).to eq("https://www.google.com/search?q=esther+duflo&stick=H4sIAAAAAAAAAONgFuLQz9U3MLWsMFTiArFMDEyyi3K0lLOTrfQTyxOLUiCkVW5-cYlCUWpyal6JQnlmXl5qUfEjxh2M3AIvf9wTllrHOGnNyWuMyxm5iNEopMLF5ppXkllSKSTFxSMFd4EGgxQXF8I9YUZeuy5NO8fmIljQycDwgSvUQUpESYiL3bPYJz85MUeQAQw-2CspcupXWy3I6nxvL_hV5X-9dJSrgwSLAoMGg2FPEyPD9WQTBy2Gpn0rDrGxcDAKMFgxaTDxLGLlSS0uyUgtUkgpTcvJBwDNMnyKCAEAAA&sa=X&ved=2ahUKEwigpNzh0NDoAhUJ6XMBHbCICCsQri4wL3oECBUQTg")
      end

      it "should extract optional extensions" do
        expect(items.first.extensions).to eq(["Literature"])
        expect(items.last.extensions).to eq(["Economic Sciences"])
      end

      it "should extract multiple extensions" do
        songs = GoogleSearchCarousel.new(IO.read("spec/files/katy-perry-songs.html")).extract
        expect(songs.first.extensions).to eq(["Con Calma", "2019"])
        expect(songs.last.extensions).to eq(["Prism", "2013"])
      end

      it "should extract optional images" do
        expect(items.first.image).to eq("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIADgAOAMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAAABQQGAgMHAf/EADEQAAIBAwMCBAQFBQEAAAAAAAECAwAEEQUSITFBBhMicRRRYYEjMjORoVKCorHRFf/EABgBAAMBAQAAAAAAAAAAAAAAAAIDBAAB/8QAHREAAgICAwEAAAAAAAAAAAAAAAECEQMhEiIxQf/aAAwDAQACEQMRAD8AqlpOshWONdxY4AHc11HwdpaWluhwNzcs4HJPvXOvBWjXN9erKkcnkR/mcDj2966xprJAjAk+gdCeB9BQY47sXBfRpKEjGN+76MagXdtJdqUJwnb51ENz58rYbPOetMRcEAHaelMTspUaFLabe2p89ZNykjr24rZFNLcxSQyRllOQSV9OPrUm+v8AEBVmIGevypXZasPWpIYLnHz4oeW6ZpQ1aKj4gtDpzn4eMqGJwvYUVYdcezntxJgBgcqMYooWiaWmY+H4kh01Yv0t/O0HGRR/6GJ5IEDBFPqc8DJ7ZpLZ3Ed3o0KHJYZ3Ef1Z60xsmc2pEsTcyEKW5JVT1/cGiUuo/HBONjS3mht/VcHn3rcdetpHWJcbicBeDnmlUthDJAVk+ICMOFtvTtP9vOK02Ojy2t3A8COWZ8Bbk5KLjqR1+2e9ZJpD2tjye/tpozHtXPKnnoareoH4OXahGCMrjpS66s70apdMlyltMJiFABAYD5HNeypdTLGkjL5m/HH5T7GuVbTOSbSaGhvQ0It8gsy87h0FFVbXb5bTU1WB2LYAdO6kcUUD9In6SvDoK2EiRlpZXUEBsBV+lWiHU7K9nMVvKvmIuXhxgpk9fuRVbh16ztNNhtkQm52YBPQfbt71lpWmzWeqzXMv6vw6kjPZmPH+NHVRH4taLTNcm0Q+RgyNwoz3NRJ9RvdLZZXjWeM5Mk+47w3y246UTp8V5SwyNGzdGXrjvx+wqFeJBDi1aa4aUd3RXX9sVkyhs1pqZvHd57b8OYkYkUckdDis7OI3M4EjeiPJAxgClwN2JlV3RoCNwYrtIIP3+dTbTULeCK4kdS5B2qB3NcYM5dKPL/RYS7zEBmPVic0UvvtYPlkHKg9ADRQURUUeW8IBfHGMknk4ruXimyNvei6jX8GSJY+BwCCzfyH/AINFFWSVwYeN1NFcjlNtKZV6c8ZrGbVJZiWIXaB1x3ooqdFbQp8S3VxDoU97aFd0LhGcD8u4j/W4VUrLxBeQW+z0PtOQCOD8wRXlFN4rRLJtslz6lbaiEPl/CnHLIS4z7H/te0UVuEQT/9k\\x3d")
        expect(items.last.image).to eq("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIADgAOAMBIgACEQEDEQH/xAAbAAACAwEBAQAAAAAAAAAAAAAABgQFBwMBAv/EADUQAAIBAwIDBgMGBwEAAAAAAAECAwAEEQUhBhIxEyJBUWFxMoGRB1KhscHRFTNCYnLh8BT/xAAaAQACAwEBAAAAAAAAAAAAAAAEBQEDBgAC/8QAJBEAAgIBBAEEAwAAAAAAAAAAAQIAAxEEEjFBIQUTIjIUI1H/2gAMAwEAAhEDEQA/AO1tH2akHp4mlDifiKS5ley06XlhXZ5R/V5/L86uuM782Gi8iHlkuG7MEdQuMsfpt86zyLBWJW2EmXb/AB8BROsvbOwGV6apfsZ9CB5SRACI+nMTu/qTXOHSZLqQw2kclxOOqxDYU08LaQNcv2RywsrfHMFOOdvAfStP07SbOwjxaW8cWRuQNz86U2ajZ47javS+4Nx4mIz6RqmhMt3JaTpAMHmI+A+tNWjalFqNvkgdoPixWk3VrG8LK4DKRgqdwayHXbNeFuJY/wDz5W0n76r90Z7y+3Q1WtvvfE8zr9Malyh8RujfsYhnJIbZfMUV5a83Zhn+FvhzRT6gMaweIksOWOYsfaJPz6jbWqk4jiGfd2/ZRSjczBTGo8IlH4Uw/aA5XiR/MRxkfL/dLEcRvb8RLsGP0GaDtP7CTC6/oAJrX2c2zW+iwOR35iZWPv0/DFOyOAeVmGay2DUNSjtks7NLhpFGAsLBOVRtuT41cKuq6bGty9y8q5XmSR+YnPUe4pPYmSWzzH1TYAUDiOmoahaWMZe6kCL6Ak/ICs2+0ySDVtMhvbKOTlt5O87rynlO3Q+uKcdc0uHWUhLOyo6A4VsZ96iS8K2iabeRRxKpmtzF3fHA7ufbauqZUYN3Ivrd1K9YlHw/dLPoNozsWdxj2IyP0oqLwNEf4V2ZZSY2JwRnAbcfrRWhqLsoI4masChiDKTj2KSTWIbhx/NgjGfmw/b61T6dE1hqSNJurrlT/wB60+8aaekvDrzbCS1XIJ8VPUfkfcVmkl27AZfocj0NDX1sDg9wil1wD/JtHDt5BdxrzKhYjqw3qVxU0UOkBvFnABCk49dqSeEb3tY1lU7Ad4eVOesm7FnE9tClwjAEqXwcfSkrrtbE0VT70zDh29tb3SYxFODPHtygHI+VW0c8jxPHKBzr4r0YedVOnyak9r2dta21rzDqQWP6CpVxKuladLNcStIUQs7H0G/SoPhhiWNkL8pl3Ct08Vxf2yMxaTlC4/tJ2996K78GXNtC6qFlluJ5eaReyOEO+CD5b/jRT+vTixc7sTN/k+3kbQZJ47vZp7IRSJNb2zN3Q+AZSPTrgfSkU2bNGpQhifDxFe0VGpyHJnioAjEudAF9pz8yoxBwcehpy0/iuNWSOcEKo2z1X0oopWwFhOY2QmlRtjZp2qWDo0klynIR94VW8QwQa1bGCS6nghDAr2ZAL433yOlFFG+maSuxyW6lPqOqcIFXxmV0tzpmiWDm3Eacg88sx8yfGiiijb7zW5VR4itKwRkz/9k\\x3d")
      end
    end

    context "when given a different google host" do
      it "should extract links with the given host" do
        items = GoogleSearchCarousel.new(IO.read("spec/files/van-gogh-paintings.html")).extract("https://www.google.ca")

        expect(items.first.link).to eq("https://www.google.ca/search?q=The+Starry+Night&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiBLFMzC3jC7WUspOt9Msyi0sTc-ITi0qQmJnFJVbl-UXZxY8YY7kFXv64JywVMmnNyWuMflxEaBJS4WJzzSvJLKkUkuLikYLbrcEgxcUF51kxaTDxLGIVCMlIVQguSSwqqlTwy0zPKAEANpnPwK4AAAA&npsic=0&sa=X&ved=2ahUKEwj4uYjEgM_oAhUZ4zgGHZEcCUcQ-BYwKnoECCIQLA")
        expect(items.last.link).to eq("https://www.google.ca/search?q=Self-Portrait+with+Grey+Felt+Hat&stick=H4sIAAAAAAAAAONgFuLQz9U3MI_PNVLiArFMiw1MTdO1lLKTrfTLMotLE3PiE4tKkJiZxSVW5flF2cWPGGO5BV7-uCcsFTJpzclrjH5cRGgSUuFic80rySypFJLi4pGCW67BIMXFBedZMWkw8SxiVQhOzUnTDcgvKilKzCxRKM8syVBwL0qtVHBLzSlR8EgsAQDCsHEmvwAAAA&npsic=0&sa=X&ved=2ahUKEwj4uYjEgM_oAhUZ4zgGHZEcCUcQ-BYwWnoFCCIQvAE")
      end
    end
  end
end
