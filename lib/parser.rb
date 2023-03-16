require 'open3'

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
    stdout, stderr, status = Open3.capture3(@chrome_path, '--headless', '--dump-dom', '--incognito', '--temp-profile', file_path)

    status.success? ? stdout : raise(RenderError, "Failed to render file: #{file_path}\n#{stderr}")
  end

  class RenderError < StandardError;
  end
end
