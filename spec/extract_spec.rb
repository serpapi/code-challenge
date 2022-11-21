require "extract"

def verify_results(results)
end

def allfields(file)
	it "correctly extracts and all fields present" do
		results = extract(File.read(file))
		results.each do |individual_thing|
			expect(individual_thing["name"]).not_to be_empty
			if(individual_thing["link"] != nil)
				expect(individual_thing["link"]).not_to be_empty
				expect(individual_thing["link"]).to start_with("https://www.google.com")
			end
			if individual_thing["image"] != nil
				expect(individual_thing["image"]).to start_with("data:image/jpeg;base64")
			end
		end
	end
end

context "Extracting from carousel" do
	it "empty string is empty list" do
		expect(extract("")).to eql []
	end
	context "format in repository" do
		allfields("files/van-gogh-paintings.html")
		it "matches json given in repository" do
			extracted_data = extract(File.read("files/van-gogh-paintings.html"))
			expected_data = JSON.parse(File.read("files/expected-array.json"))["artworks"]
			extracted_data.zip(expected_data).each do |extracted_element, expected_element|
				expect(extracted_element).to include(expected_element)
			end
		end
	end
	context "format from current google search" do
		allfields("files/chess.html")
		allfields("files/hockey.html")
		allfields("files/actors.html")
	end
end
