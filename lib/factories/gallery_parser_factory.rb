# frozen_string_literal: true

require_relative '../parsers/base_gallery_parser'
require_relative '../parsers/artwork_gallery_parser'
require_relative '../parsers/music_albums_gallery_parser'
require_relative '../parsers/author_books_gallery_parser'
require_relative '../parsers/person_tv_shows_and_movies_gallery_parser'

class GalleryParserFactory
  def self.from_page(page)
    gallery_klass(page).new
  end

  # Not the most elegant, but it's a quick and working solution.
  # Can be optimized later if needed.
  # rubocop:disable Metrics/MethodLength
  def self.gallery_klass(page)
    if page.css('div[data-attrid="kc:/visual_art/visual_artist:works"]').any?
      ArtworkGalleryParser
    elsif page.css('div[data-attrid="kc:/music/artist:albums"]').any?
      MusicAlbumsGalleryParser
    elsif page.css('div[data-attrid="kc:/book/author:books only"]').any?
      AuthorBooksGalleryParser
    elsif page.css('div[data-attrid="kc:/people/person:tv-shows-and-movies"]').any?
      PersonTVShowsAndMoviesGalleryParser
    else
      raise 'Unknown gallery type'
    end
  end
  # rubocop:enable Metrics/MethodLength
end
