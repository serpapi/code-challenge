# Extract Van Gogh Paintings Code Challenge

- **Planning:** 

1. FileManager Class: read HTML file from the files folder.
   - read_file takes a file path and reads the content of the file, and returns it
   - write_to_file takes a file path and data, and writes the data to the file in JSON format. 
2. HtmlDocument Class: create a new object and parse the content using Nokogiri
3. ArtworkExtractor Class:
   - Initialize the class with a single 'a' element from the carousel
4. Artwork Class:
   - Initialize the class with name, image link, Google link and extension
   - to_hash that returns a hash of the art including name, image link google link, and extension

- **Proposed Process:**
  1. Use FileManager to read the HTML content
  2. Create an HtmlDocument parse the HTML content
  3. For each 'a' element in the carousel of the HtmlDocument:
     - Create an ArtworkExtractor with the 'a' element.
     - If the ArtworkExtractor indicates that a artwork exists:
       - Use the methods of the ArtworkExtractor to extract the painting's data.
       - Create a new Artwork object with this data.
       - Add the Artwork object (converted to a hash using the to_hash method) to a list of artworks.
  4. Use FileManager to write the list of artworks (in hash format) to a JSON file.
  5. Return the list of artworks (in hash format). 

- **How to run:**
  1. Run `bundle install` to install the necessary dependencies.
  2. Run `ruby main.rb` to start the project.
  3. Select the desired option for Van Gogh, Picasso, or Da Vinci artwork extraction.
  4. Once the process completes, a JSON file containing the extracted artworks will be generated in the files folder.

- **Write up:**
  I faced several obstacles while finishing the project, but I also gained important knowledge. One important finding was that different HTML structures require various processing techniques. The two other similar result pages I checked had different formats from the original Van Gogh HTML file, which had a different and constant structure(can refer to files/picasso-paintings_old.html). As a result, parsing the attributes became more challenging. 

  One specific problem that came up has to do with the Google link. The Google link in the Van Gogh HTML file did not have the "https://www.google.com" prefix. The Google URL, on the other hand, was prefixed with "https://www.google.com" in the other two samples I downloaded. The proper extraction of the link was difficult due to this difference.I modified the parsing logic by adding a conditional check to find the prefix in order to solve the problem with the variations in the Google link. It appears, however, that this approach fell short of providing a comprehensive solution. In light of this, I would now proceed to further analyze the problem and choose various methods for dealing with the differences in the Google link. I would also think about more precisely extracting the Google URL using regular expressions or string manipulation methods. These techniques may be used to locate and isolate the relevant part of a link, regardless of how the prefix or other HTML components may vary.