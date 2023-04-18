# frozen_string_literal: true

require 'json'

module SerpApiDesktopJSON
  # Thrown on a missing or unreadable file
  class InvalidFile < StandardError
    MSG = 'Missing or unreadable file at "%<path>s"'

    def initialize(path)
      super format(MSG, path: path)
    end
  end

  # Parses a knowledge graph, for an image-containing search. Expects a json
  # file.
  class KnowledgeGraphParser
    def initialize(path)
      raise InvalidFile, path unless File.readable? path

      @json = JSON.load_file path
    end

    def respond_to_missing?(name, *)
      @json['knowledge_graph'].key?(name.to_s) || rich_snippets.key?(name.to_s)
    end

    def method_missing(name)
      @json['knowledge_graph'][name.to_s] || rich_snippets[name.to_s]
    end

    private

    # I'm not sure that this is what we want. But, seems like it's forward thinking in
    # the limited number of results we're spec'ing
    def rich_snippets
      @rich_snippets ||= @json['organic_results']
        .select { |result| result.key? 'rich_snippet' }
        .map { |result| result['rich_snippet'].values.map(&:values) }.flatten
        .each_with_object({}) do |result, sum|
          sum.merge!(if result.is_a? Hash
            result
          elsif /\A([^:]+): *(.*)\Z/.match result
            # There are some odd characters in the key, that we don't have a use for...
            # probably this list of characters is insufficient...
            Hash[[(1..2).map { |i| ::Regexp.last_match(i).tr('^a-zA-Z0-9 ','') }]]
          else
            # NOTE: If I understood a bit more about where this was going, I'd
            # probably raise an error here...
            {}
          end)
        end
        .transform_keys(&:downcase) # NOTE: This is probably a bad idea outside the the limited test cases...
    end
  end
end
