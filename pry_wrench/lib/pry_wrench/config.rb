module PryWrench

  class Config

    def initialize(c = {})
      @root_folder = c[:root_folder]
      @config_file = c[:config_file]
      @database_url = c[:database_url]
    end

    def root_folder
      @root_folder ||= gather_parameters('ROOT_FOLDER')
    end

    def config_file
      @config_file ||= gather_parameters('CONFIG_FILE')
    end

    def database_url
      @database_url ||= gather_parameters('DATABASE_URL')
    end

    # private

    def gather_parameters(param_name)
      ENV["PRY_WRENCH_#{param_name.upcase}"] || default_constant_or_nil(param_name)
    end

    def default_constant_or_nil(param_name)
      const_name = 'DEFAULT_' + param_name
      root_module = Module.nesting.last
      root_module.const_get(const_name) if root_module.const_defined?(const_name)
    end
  end

end
