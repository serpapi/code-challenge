require_relative '../search'

describe 'Knowledge Graph API' do
  [
    { q: 'Van Gogh paintings', file_path: 'files/van-gogh-paintings.html' },
    { q: 'Harry Harryson books', file_path: 'files/harry-harrison-books.html', version: :new },
    { q: 'Pink Floyd albums', file_path: 'files/pink-floyd-albums.html', version: :new },
    { q: 'Van Gogh paintings new', file_path: 'files/van-gogh-paintings-new.html', version: :new }
  ].each do |search_params|
    describe "Knowledge Graph for #{ search_params[:q] }, filepath: #{ search_params[:file_path] }" do
      before :all do
        @search = Search.new(search_params)
      end

      it 'Should contain knowledge graph results Hash' do
        @search.html_to_hash[:knowledge_graph].should be_an(Hash)
      end

      describe 'Knowledge graph for results' do
        {
          title: String
        }.each do |attribute, type|
          it "Has a #{ attribute }" do
            @search.html_to_hash[:knowledge_graph][attribute].should be_a_kind_of(type).and(be_truthy)
          end
        end

        it 'contains array with artworks' do
          @search
            .html_to_hash[:knowledge_graph][@search.knowledge_graph.carousel_items_key]
            .should be_a_kind_of(Array)
            .and(be_truthy)
        end

        describe 'Artworks results' do
          {
            name: String,
            extensions: Array,
            link: String,
            image: String
          }.each do |attribute, type|
            it "Has a #{ attribute }" do
              @search
                .html_to_hash[:knowledge_graph][@search.knowledge_graph.carousel_items_key]
                .first[attribute]
                .should be_a_kind_of(type)
                .and(be_truthy)
            end
          end
        end
      end
    end
  end
end
