require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

# The entry point for Parser
#
module Parser
end

loader.eager_load
