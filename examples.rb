require_relative 'parser'
require 'json'
# van-gogh
html = File.read("files/van-gogh-paintings.html")
tokens = tokenize(html)
doc = parse(tokens)
scripts  = css(doc,"script")
image_map = extract_inline_js_images_google(scripts)

artworks = css(doc,'.iELo6').map do |node|
  img_node = css_first(node, 'img')
  img_src = img_node[:attributes]["src"]

  if img_src.nil? || img_src.empty? || img_src == "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
    img_src = img_node[:attributes]["data-src"]
  end

  if img_src.nil? || img_src.empty?
    img_id = img_node[:attributes]["id"]
    img_src = image_map[img_id]
  end

  href =  css_first(node,'a')[:attributes]["href"]
  link = href.empty? ? "" : "https://www.google.com" + css_first(node,'a')[:attributes]["href"]
  extension = css_first(node,'div.cxzHyb')[:text]
  name = css_first(node,'div.pgNMRc')[:text]

  artwork = {
    "name" => name,
    "extensions" => extension.empty? ? nil : [extension],
    "link" => link,
    "image" => img_src,
  }.compact

  artwork
end
File.write("outputs/van_gogh.json", JSON.pretty_generate({artworks:artworks}))

# monet
html = File.read("files/monet - Google Search.html")
tokens = tokenize(html)
doc = parse(tokens)
scripts  = css(doc,"script")
image_map = extract_inline_js_images_google(scripts)

artworks = [css_first(doc,'.TzHB6b.j8lBAb.p7kDMc.cLjAic.LMRCfc')].map do |artworks_node|
  css(artworks_node,'.IF221e').map do |node|
    img_node = css_first(node, 'img')
    img_src = img_node[:attributes]["src"]

    if img_src.nil? || img_src.empty? || img_src == "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
      img_src = img_node[:attributes]["data-src"]
    end

    if img_src.nil? || img_src.empty?
      img_id = img_node[:attributes]["id"]
      img_src = image_map[img_id]
    end

    link =  css_first(node,'a')[:attributes]["href"]
    extension = css_first(node,'span.PeZnd')[:text]
    name = css_first(node,'span.Yt787')[:text]

    artwork = {
      "name" => name,
      "extensions" => extension.empty? ? nil : [extension],
      "link" => link,
      "image" => img_src,
    }.compact

    artwork
  end
end
File.write("outputs/monet.json", JSON.pretty_generate({artworks:artworks.flatten}))


# Christofer nolan
html = File.read("files/christopher nolan - Google Search.html")
tokens = tokenize(html)
doc = parse(tokens)
scripts  = css(doc,"script")
image_map = extract_inline_js_images_google(scripts)

movies = [css_first(doc,'.TzHB6b.j8lBAb.p7kDMc.cLjAic.LMRCfc')].map do |movies_node|
  css(movies_node,'.IF221e').map do |node|
    img_node = css_first(node, 'img')
    img_src = img_node[:attributes]["src"]

    if img_src.nil? || img_src.empty? || img_src == "data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
      img_src = img_node[:attributes]["data-src"]
    end

    if img_src.nil? || img_src.empty?
      img_id = img_node[:attributes]["id"]
      img_src = image_map[img_id]
    end

    link =  css_first(node,'a')[:attributes]["href"]
    extension = css_first(node,'span.PeZnd')[:text]
    name = css_first(node,'span.Yt787')[:text]

    artwork = {
      "name" => name,
      "extensions" => extension.empty? ? nil : [extension],
      "link" => link,
      "image" => img_src,
    }.compact

    artwork
  end
end
File.write("outputs/nolan.json", JSON.pretty_generate({movies:movies.flatten}))
