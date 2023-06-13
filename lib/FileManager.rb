require 'nokogiri'
require 'json'


class FileManager
    def self.read_file(file_path)
    # Reads a file at the given path and returns its content
        File.read(file_path)
    end

    def self.write_to_file(file_path, data)
    # Converts the data to JSON and writes it to a file at the given path
        File.open(file_path, 'w') do |f|
        f.write('"artworks": ')
        f.write(JSON.pretty_generate(data))
        end
    end
end