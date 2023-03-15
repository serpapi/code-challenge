class Parser
  def initialize(file_path)
    @file_path = file_path
  end

  def parse
    @doc = Nokolexbor::HTML(rendered_file)
  end

  private

  def file
    @file ||= File.open(@file_path)
  end

  def rendered_file
    @rendered_file ||= begin
      `#{chrome_bin} --headless --headless --dump-dom --incognito --temp-profile #{@file_path} 2> /dev/null`
    end
  end

  def chrome_bin
    ENV.fetch('CHROME_BIN', 'google-chrome-stable')
  end
end
