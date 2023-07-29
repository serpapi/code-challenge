# frozen_string_literal: true

require 'digest'
require 'zlib'

class CacheHandler

  GENERIC_EXPIRATION = 86400
  CACHE_FOLDER = 'cache'

  def initialize(key:, expiration: nil)
    @key = key
    @expiration = expiration || GENERIC_EXPIRATION
  end

  def exists?
    cache_file = CACHE_FOLDER + '/' + prepare_key
    exists = File.exist?(cache_file)
    if exists
      file_stats = File.stat(cache_file)
      creation_time = file_stats.ctime
      if (Time.now - creation_time) >= @expiration
        File.delete(cache_file)
        exists = false
      end
    end
    exists
  end

  def read
    cache_file = CACHE_FOLDER + '/' + prepare_key
    if File.exist?(cache_file)
      @content = get_compressed_content(cache_file:)
    end
  end

  def store(value:)
    prepared_key = prepare_key
    prepared_content = compress_content(value:)
    File.write("cache/#{prepared_key}", prepared_content)
  end

  private

  def prepare_key
    prepared_key = Digest::MD5.new
    prepared_key.update(@key)
    prepared_key.hexdigest
  end

  def compress_content(value:)
    compressed_data = StringIO.new
    gzip_writer = Zlib::GzipWriter.new(compressed_data)
    gzip_writer.write(value)
    gzip_writer.close
    compressed_data.string
  end

  def get_compressed_content(cache_file:)
    File.open(cache_file, 'rb') do |file|
      gzip_reader = Zlib::GzipReader.new(file)
      decompressed_data = gzip_reader.read
      gzip_reader.close
      return decompressed_data
    end
  end
end