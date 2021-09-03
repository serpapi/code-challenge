require_relative '../search'

describe 'Knowledge Graph API' do
  [
    { q: 'Van Gogh paintings', file_path: 'files/van-gogh-paintings.html' },
  ].each do |search_params|
    describe "Knowledge Graph for Van Gogh Paintings, filepath: #{search_params[:file_path]}" do
      before :all do
        search = Search.new(search_params)

        @knowledge_graph = search.html_to_hash[:knowledge_graph]
      end

      it 'Should contain knowledge graph results Hash' do
        @knowledge_graph.should be_an(Hash)
      end

      describe 'Knowledge graph for results' do
        {
          title: String,
          artworks: Array
        }.each do |attribute, type|
          it 'Has a #{attribute}' do
            @knowledge_graph[attribute].should be_a_kind_of(type).and(be_truthy)
          end
        end

        describe 'Artworks results' do
          {
            name: String,
            extensions: Array,
            link: String,
            image: String
          }.each do |attribute, type|
            it 'Has a #{attribute}' do
              @knowledge_graph[:artworks][0][attribute].should be_a_kind_of(type).and(be_truthy)
            end
          end
        end
      end
    end
  end
end
