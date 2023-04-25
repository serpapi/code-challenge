# Extract Van Gogh Paintings Code Challenge

## Instructions

Use `bundle install` to install dependencies
Use `rspec` to run the specs
Use `ruby run.rb` to run the code, which will print out a menu
```
Enter which page you want to scrape:
 1. Van Gogh
 2. Tom Cruise
 3. Tina Fey
 exit to exit
```
And you can choose which file you would like to scrape, and JSON will be printed to the terminal.

## Notes

I used the `nokogiri` gem to parse the HTML, and I've found that the image src contains only a partial one-pixel image instead of a full one. I figured out that I could pull it out from javascript, but I didn't know if I should, so I have displayed it in the other examples I have used.
If you want me to use the javascript to pull out the full image, I can do that, but I figured I would leave it as is for now.

Great challenge! I had a lot of fun with it. I hope you like it! :D 
