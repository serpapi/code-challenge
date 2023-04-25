require "html_extractor"

describe HtmlExtractor do

    before(:all) do
        @html_extractor = HtmlExtractor.new("/Users/rohitverma/dev/code-challenge/files/hp-films-2.html")
        # @html_extractor = HtmlExtractor.new("/Users/rohitverma/dev/code-challenge/files/van-gogh-paintings.html")
    end

    describe "should be able to read html" do
        context "given an search html file" do
            it "should return the carousel parent div and have correct number of children" do
                photos_carousel = @html_extractor.get_photos_carousel_from_html()
                expect(photos_carousel).to_not be_nil
                expect(photos_carousel.children[0].children[0].children).to_not be_nil
                expect(photos_carousel.children[0].children[0].children[0]).to_not be_nil
            end
        end
        context "given a single search's carousel div" do
            it "should be able to retrieve corresponding information about the result" do
                photos_carousel = @html_extractor.get_photos_carousel_from_html()
                single_carousel_div = photos_carousel.children[0].children[0].children[0]
                img = @html_extractor.get_image_attribute_from_div(single_carousel_div)
                link = @html_extractor.get_link_from_div(single_carousel_div)
                name = @html_extractor.get_name_from_div(single_carousel_div)
                extensions = @html_extractor.get_extensions_from_div(single_carousel_div)
                expect(img).to_not be_nil
                expect(img.length).to be > 0
                expect(link).to_not be_nil
                expect(link.length).to be > 0
                expect(name).to_not be_nil
                expect(name.length).to be > 0
                expect(extensions).to_not be_nil
                expect(extensions.length).to be 1
            end
        end

    end

    describe "extract single painting information" do

        context "given a carousel div" do
            it "should return formatted data" do
                photos_carousel = @html_extractor.get_photos_carousel_from_html()
                single_carousel_div = photos_carousel.children[0].children[0].children[0]
                extract_single_painting_information = @html_extractor.extract_single_painting_information(single_carousel_div)
                expect(extract_single_painting_information).to have_key("name")
                expect(extract_single_painting_information["name"].length).to be > 0
                expect(extract_single_painting_information).to have_key("extensions")
                expect(extract_single_painting_information).to have_key("link")
                expect(extract_single_painting_information["link"].length).to be > 0                    
                expect(extract_single_painting_information).to have_key("image")
                expect(extract_single_painting_information["image"].length).to be > 0                     
            end
        end
        
        context "given multiple paintings data" do
            it "should return an array of paintings" do
                all_paintings_result = @html_extractor.extract_all_paintings_information()
                expect(all_paintings_result).to have_key("artworks")
                expect(all_paintings_result["artworks"]).to be_an_instance_of(Array)

                for each_painting_result in all_paintings_result["artworks"] do
                    expect(each_painting_result).to have_key("name")
                    expect(each_painting_result["name"].length).to be > 0
                    expect(each_painting_result).to have_key("extensions")
                    expect(each_painting_result).to have_key("link")
                    expect(each_painting_result["link"].length).to be > 0                    
                    expect(each_painting_result).to have_key("image")
                    expect(each_painting_result["image"].length).to be > 0                     
                end
            end
        end
    end

end
