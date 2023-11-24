require 'rails_helper'

RSpec.describe ArtworksController, type: :controller do

  describe 'GET #index' do

    it 'should have a route' do
      expect(get: root_path).to route_to controller: 'artworks', action: 'index'
    end

    it 'request should be successful' do
      get :index
      expect(response).to be_successful
    end

    it 'each object should contain a name string' do
      get :index
      data_array = JSON.parse(response.body)['artworks']
      expect(data_array.first['name']).to be_an(String)
      expect(data_array.first['name']).to eq('The Starry Night')
    end

    it 'each object should contain extensions array' do
      get :index
      data_array = JSON.parse(response.body)['artworks']
      expect(data_array.first['extensions']).to be_an(Array)
      expect(data_array.first['extensions']).to eq(["1889"])
    end

    it 'each object should contain link string' do
      get :index
      data_array = JSON.parse(response.body)['artworks']
      expect(data_array.first['link']).to be_an(String)
    end

    it 'each object should contain image string' do
      get :index
      data_array = JSON.parse(response.body)['artworks']
      expect(data_array.first['image']).to be_an(String)
    end

  end

end