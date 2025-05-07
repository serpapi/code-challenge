# frozen_string_literal: true

require 'rspec'
require 'json'
require 'open3'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'extract_artwork_details.rb' do
  let(:script_path) { File.expand_path('../scripts/extract_artwork_details.rb', __dir__) }

  # rubocop:enable Metrics/BlockLength
  context 'when extracting artworks' do
    let(:input_file) { File.expand_path('../files/van-gogh-paintings.html', __dir__) }

    it 'extracts artworks and outputs valid JSON' do
      stdout, stderr, status = Open3.capture3('ruby', script_path, '--input', input_file)
      if status.exitstatus != 0
        warn "STDOUT:\n#{stdout}"
        warn "STDERR:\n#{stderr}"
      end
      expect(status.exitstatus).to eq(0),
                                   "Script exited with status #{status.exitstatus}."
      data = JSON.parse(stdout)
      expect(data).to have_key('artworks')
      expect(data['artworks']).to be_a(Array)
      expect(data['artworks']).to_not be_empty
      expect(data['artworks'].first).to include('name', 'extensions', 'link', 'image')
    end
  end
  context 'when extracting albums from lady-gaga-albums.html' do
    let(:input_file) { File.expand_path('../files/lady-gaga-albums.html', __dir__) }

    it 'extracts albums and outputs valid JSON' do
      stdout, stderr, status = Open3.capture3('ruby', script_path, '--input', input_file)
      if status.exitstatus != 0
        warn "STDOUT:\n#{stdout}"
        warn "STDERR:\n#{stderr}"
      end
      expect(status.exitstatus).to eq(0),
                                   "Script exited with status #{status.exitstatus}."
      data = JSON.parse(stdout)
      expect(data).to have_key('artworks')
      expect(data['artworks']).to be_a(Array)
      expect(data['artworks']).to_not be_empty
      expect(data['artworks'].first).to include('name', 'extensions', 'link', 'image')
    end
  end
  context 'when extracting books from jk-rowling-books.html' do
    let(:input_file) { File.expand_path('../files/jk-rowling-books.html', __dir__) }

    it 'extracts books and outputs valid JSON' do
      stdout, stderr, status = Open3.capture3('ruby', script_path, '--input', input_file)
      if status.exitstatus != 0
        warn "STDOUT:\n#{stdout}"
        warn "STDERR:\n#{stderr}"
      end
      expect(status.exitstatus).to eq(0),
                                   "Script exited with status #{status.exitstatus}."
      data = JSON.parse(stdout)
      expect(data).to have_key('artworks')
      expect(data['artworks']).to be_a(Array)
      expect(data['artworks']).to_not be_empty
      expect(data['artworks'].first).to include('name', 'extensions', 'link', 'image')
    end
  end
  context 'when extracting artworks from da-vinci-paintings.html' do
    let(:input_file) { File.expand_path('../files/da-vinci-paintings.html', __dir__) }

    it 'extracts artworks and outputs valid JSON' do
      stdout, stderr, status = Open3.capture3('ruby', script_path, '--input', input_file)
      if status.exitstatus != 0
        warn "STDOUT:\n#{stdout}"
        warn "STDERR:\n#{stderr}"
      end
      expect(status.exitstatus).to eq(0),
                                   "Script exited with status #{status.exitstatus}."
      data = JSON.parse(stdout)
      expect(data).to have_key('artworks')
      expect(data['artworks']).to be_a(Array)
      expect(data['artworks']).to_not be_empty
    end
  end
  describe 'artworks details' do
    before(:all) do
      script_path = File.expand_path('../scripts/extract_artwork_details.rb', __dir__)
      input_file = File.expand_path('../files/da-vinci-paintings.html', __dir__)
      stdout, _stderr, status = Open3.capture3('ruby', script_path, '--input', input_file)
      raise 'Script failed' unless status.exitstatus == 0

      @json = JSON.parse(stdout)
    end
    it 'artworks - name' do
      expect(@json['artworks'][0]['name']).to be_a(String)
      expect(@json['artworks'][0]['name']).to_not be_empty
    end
    it 'artworks - extensions' do
      expect(@json['artworks'][0]['extensions']).to be_a(Array)
      expect(@json['artworks'][0]['extensions']).to_not be_empty
    end
    it 'artworks - link' do
      expect(@json['artworks'][0]['link']).to be_a(String)
      expect(@json['artworks'][0]['link']).to_not be_empty
    end
    it 'artworks - image' do
      expect(@json['artworks'][0]['image']).to be_a(String)
      expect(@json['artworks'][0]['image']).to_not be_empty
    end
  end
  describe 'albums details' do
    before(:all) do
      script_path = File.expand_path('../scripts/extract_artwork_details.rb', __dir__)
      input_file = File.expand_path('../files/lady-gaga-albums.html', __dir__)
      stdout, _stderr, status = Open3.capture3('ruby', script_path, '--input', input_file)
      raise 'Script failed' unless status.exitstatus == 0

      @json = JSON.parse(stdout)
    end
    it 'albums - name' do
      expect(@json['artworks'][0]['name']).to be_a(String)
      expect(@json['artworks'][0]['name']).to_not be_empty
    end
    it 'albums - extensions' do
      expect(@json['artworks'][0]['extensions']).to be_a(Array)
    end
    it 'albums - link' do
      expect(@json['artworks'][0]['link']).to be_a(String)
      expect(@json['artworks'][0]['link']).to_not be_empty
    end
    it 'albums - image' do
      expect(@json['artworks'][0]['image']).to be_a(String)
      expect(@json['artworks'][0]['image']).to_not be_empty
    end
  end
  describe 'books details' do
    before(:all) do
      script_path = File.expand_path('../scripts/extract_artwork_details.rb', __dir__)
      input_file = File.expand_path('../files/jk-rowling-books.html', __dir__)
      stdout, _stderr, status = Open3.capture3('ruby', script_path, '--input', input_file)
      raise 'Script failed' unless status.exitstatus == 0

      @json = JSON.parse(stdout)
    end
    it 'books - name' do
      expect(@json['artworks'][0]['name']).to be_a(String)
      expect(@json['artworks'][0]['name']).to_not be_empty
    end
    it 'books - extensions' do
      expect(@json['artworks'][0]['extensions']).to be_a(Array)
    end
    it 'books - link' do
      expect(@json['artworks'][0]['link']).to be_a(String)
      expect(@json['artworks'][0]['link']).to_not be_empty
    end
    it 'books - image' do
      expect(@json['artworks'][0]['image']).to be_a(String)
      expect(@json['artworks'][0]['image']).to_not be_empty
    end
  end
end
