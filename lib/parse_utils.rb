require 'nokogiri'
require 'json'
require 'uri'

module ParseUtils
  # parse_image_group finds all links with images, extracting any adjacent text
  # tags. If a base_url is given, it is used to return absolute URLs instead of
  # relative ones.
  def self.parse_image_group(elem, base_url)
    elem.css("a:has(img)").reduce([]) do |list, a|
      img = a.css("img")
      id = img&.attr("id")&.value
      alt = img&.attr("alt")&.value
      src = img&.attr("data-src")&.value
      next list unless alt

      href = a.attr("href")
      href = base_url.merge(URI.parse(href)).to_s if base_url

      ext = a.xpath('.//div/text()').map(&:to_s).map(&:strip)
      ext.delete(alt)
      # remove empty text nodes. Google doesn't insert them, but it's convenient
      # for tests.
      ext.delete("")

      list << {name: alt, id: id, image_src: src, link: href, extensions: ext}
    end
  end

  # parse_script_images extracts all script elements containing inline encoded
  # images. It returns a map where the keys are "the script without the image" and
  # the values are the images themselves. The image ID is intentionally not
  # extracted to avoid adjusting on small JS changes.
  def self.parse_script_images(elem)
    elem.css("script").reduce({}) do |map, script|
      raw = script.text()
      start = raw.index("data:image/")
      next map unless start || start == 0

      delim = raw[start-1]
      img = raw[start..-1]
      stop = img.index(delim)

      next map unless stop || stop < 1
      img = img[0..stop-1]
      # since = is the only base64 character that is being escaped, we don't
      # need to implement a fancier parser to unescape all string-escaped hex
      # characters.
      img.gsub!("\\x3d", "=")

      prefix = raw[0..start]
      suffix = raw[start+stop..-1]

      map[prefix + suffix] = img
      map
    end
  end

  # read_crawl_metadata reads SerpAPI's crawl metadata, assuming they are placed
  # next to each other. The filenames should match, apart from the file extension.
  def self.read_crawl_metadata(html_path)
    metadata_path = html_path.sub(/\.html/, ".json")
    JSON.load_file(metadata_path)
  rescue => e
    warn "failed to read crawl metadata (expected file at #{metadata_path}): #{e}"
    nil
  end

  # google_url returns the parsed search URL, if given SerpAPI metadata.
  def self.google_url(meta)
    str = meta&.dig("search_metadata", "google_url")
    URI.parse(str) if str
  end

  # parse_gallery reads the given HTML file and extracts all images available in
  # the image gallery.
  def self.parse_gallery(page, base_url)
    all_groups = page.css("[data-attrid^='kc:/']")
    main_group = all_groups.first
    knowledge_graph_id = main_group&.attr("data-attrid")
    return nil, [] unless knowledge_graph_id

    gallery = parse_image_group(main_group, base_url)

    images = parse_script_images(page)
    gallery.each do |entry|
      id = entry.fetch(:id)
      next unless id
      img_key = images.keys.find { |k| k.include?(id) }
      entry[:image] = images[img_key]
    end

    return knowledge_graph_id, gallery
  end

  # format_gallery extracts artwork galleries from the page and outputs them in
  # API format.
  def self.format_gallery(page, base_url)
    kc_id, gallery = parse_gallery(page, base_url)
    api_id = KNOWLEDGE_GRAPH_ID_MAPPER[kc_id]
    return {} unless api_id

    formatted = gallery.map do |entry|
      f = {
        "name" => entry.fetch(:name),
        "link" => entry.fetch(:link),
        "image" => entry[:image] || entry[:image_src],
      }
      f["extensions"] = entry[:extensions] unless entry.fetch(:extensions).empty?
      f
    end

    { api_id => formatted }
  end

  # parse_file reads the HTML file and associated SerpAPI metadata and returns
  # the result in API format.
  def self.parse_file(html_file_path)
    html = File.read(html_file_path)
    page = Nokogiri::HTML.parse(html)

    meta = read_crawl_metadata(html_file_path)
    base_url = google_url(meta)

    [
      format_gallery(page, base_url)
      # add more parsers here
    ].reduce(:merge)
  end

  KNOWLEDGE_GRAPH_ID_MAPPER = {
    "kc:/visual_art/visual_artist:works" => "artworks"
  }
end

