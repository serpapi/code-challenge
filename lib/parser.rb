class Parser
  DEFAULT_CHROME_PATH = 'google-chrome-stable'

  def initialize(chrome_path: DEFAULT_CHROME_PATH)
    @chrome_path = chrome_path
  end

  def parse(file_path)
    @doc = Nokolexbor::HTML(render_file(file_path))
  end

  private

  def render_file(file_path)
    output = `#{@chrome_path} --headless --headless --dump-dom --incognito --temp-profile #{file_path} 2> /dev/null`
    $?.success? ? output : raise("Failed to render file: #{file_path}")
  end
end
