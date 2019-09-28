require 'webdrivers'
require 'watir'

def extract_items
  browser = Watir::Browser.new
  browser.goto(get_url)
  browser.div(class: 'klcc').wait_until(&:present?)

  extracted_items = browser.as(class: 'klitem').map {|item| extract_item(item) }
end

def extract_item(item)
  if item.img.src.include?("data:image/")
    image = item.img.src 
  end

  data = {
    :name => item.div(class: 'kltat').text,
    :link => 'https://www.google.com' + item.href.sub("file://", ""),
    :image => image
  }

  if item.div(class: 'klmeta').exists?
    data[:extensions] = [item.div(class: 'klmeta').text]
  end

  data
end

def write_output(path, items)
  File.write(path, JSON.pretty_generate(items))
end

def get_url
  "file:///#{Dir.pwd}/files/van-gogh-paintings.html"
end
