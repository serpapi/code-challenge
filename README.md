# Carousel extractor

Hi there. This neat little program can extract thumbnails and information from a google carousel representation.

#### Installation
You will need the following prerequisites:

- Ruby 3.2.2
- Bundler (get the 2.4.18 or newer)

After a call to `bundle install`, you should be golden :-)!


#### Calling it from the terminal

You can call the script e.g. like so:
<pre>ruby ./lib/services/carousel_parser.rb ./files/buildings-in-bonn.html</pre>


If you want to pipe the content into a file, then you can use this command:
<pre>ruby ./lib/services/carousel_parser.rb ./files/buildings-in-bonn.html > my_results.json</pre>

If you want to change the default root node name and pipe the content into a file, then you can use this command:
<pre>ruby ./lib/services/carousel_parser.rb ./files/buildings-in-bonn.html buildings> my_results.json</pre>
