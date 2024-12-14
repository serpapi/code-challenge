require_relative './scraper/knowledge_graph'
require 'json'

FILES_DIR = './files'

%w[van-gogh-paintings-new].each do |path|
  File.open(File.join(FILES_DIR, "#{path}.html")) do |html|
    result = JSON.pretty_generate(KnowledgeGraph.new(html).to_h)

    File.open(File.join(FILES_DIR, "#{path}-result.json"), 'w') { |f| f.write(result) }
  end
end
