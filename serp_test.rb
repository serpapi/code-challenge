require_relative "serp.rb"
require "json"

describe "Google Serp Parsing" do

  describe "Initial Van Gogh Page" do

    before :all do
      @file_name = "van-gogh-paintings.html"
      @main_json_key = "artworks"
    end

    it "matches expected array json file" do
      actual_json = get_serp_for_file(@file_name, @main_json_key)

      raw_file = File.read(File.join(__dir__, "files", "expected-array.json"))
      expected_json = JSON.parse("{" + raw_file + "}")

      expect(expected_json.keys.to_s).to eq(actual_json.keys.to_s)
      expect(expected_json.keys.length).to be(1)

      actual_dict_list = actual_json.values[0]
      expected_dict_list = expected_json.values[0]

      expect(expected_dict_list.length).to be(actual_dict_list.length)
      expect(expected_dict_list).to_not be_empty

      expected_dict_list.zip(actual_dict_list).each do |expected_dict, actual_dict|
        expect(expected_dict.keys.to_s).to eq(actual_dict.keys.to_s)
        expect(expected_dict.keys).to_not be_empty

        expected_dict.keys.each do |cur_key|
          expect(expected_dict[cur_key]).to eq(actual_dict[cur_key])
        end
      end

      # last check for dict string equality
      expect(expected_json.to_s).to eq(actual_json.to_s)
    end

  end

  describe "Other Carousel Pages" do

    it "works for U.S. presidents" do
      file_name = "us-presidents.html"
      main_json_key = "presidents"
      actual_json = get_serp_for_file(file_name, main_json_key)

      expect(actual_json.keys.to_s).to eq([main_json_key].to_s)
      expect(actual_json[main_json_key]).to_not be_empty

      actual_json[main_json_key].each do |cur_dict|
         expect(cur_dict).to have_key("name")
         expect(cur_dict).to have_key("link")
         expect(cur_dict).to have_key("image")

         expect(cur_dict["name"]).not_to be_nil
         expect(cur_dict["link"]).not_to be_nil
      end

      first_name = "Joe Biden"
      first_extensions = ["2021-"]

      expect(actual_json[main_json_key].first["name"]).to eq(first_name)
      expect(actual_json[main_json_key].first["extensions"].to_s).to eq(first_extensions.to_s)
    end

    it "works for movies near me" do
      file_name = "movies-near-me.html"
      main_json_key = "movies"
      actual_json = get_serp_for_file(file_name, main_json_key)

      expect(actual_json.keys.to_s).to eq([main_json_key].to_s)
      expect(actual_json[main_json_key]).to_not be_empty

      actual_json[main_json_key].each do |cur_dict|
         expect(cur_dict).to have_key("name")
         expect(cur_dict).to have_key("link")
         expect(cur_dict).to have_key("image")

         expect(cur_dict["name"]).not_to be_nil
         expect(cur_dict["link"]).not_to be_nil
      end

      first_name = "Barbie"
      first_extensions = ["PG-13 (USA)", "1h 54m", "Comedy/Drama"]

      expect(actual_json[main_json_key].first["name"]).to eq(first_name)
      expect(actual_json[main_json_key].first["extensions"].to_s).to eq(first_extensions.to_s)
    end

  end

end
