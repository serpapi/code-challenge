class NokolexborAdapter
  class NokolexborDocument
    def initialize(document)
      @document = document
    end

    def css(selector)
      @document.css(selector)
    end
  end

  def parse(file)
    NokolexborDocument.new(Nokolexbor::HTML(file))
  end
end

class Parser
  def initialize(file_path, adapter: NokolexborAdapter.new)
    @file_path = file_path
    @adapter = adapter
  end

  def parse
    @doc = @adapter.parse(rendered_file)
  end

  private

  def file
    @file ||= File.open(@file_path)
  end

  def rendered_file
    @rendered_file ||= `#{chrome_bin} --headless --headless --dump-dom --incognito --temp-profile #{@file_path}`
  end

  def chrome_bin
    ENV.fetch('CHROME_BIN', 'google-chrome-stable')
  end
end
