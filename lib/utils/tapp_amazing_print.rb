# frozen_string_literal: true

require 'tapp'
require 'tapp/printer'
require 'amazing_print'

# Module to define own Tapp printer
module Tapp::Printer
  # Custom AmazingPrint based printer for Tapp
  class AmazingPrint < Base
    # Prints the object using custom (AmazingPrint) printer
    #
    # @param [Object, Array] *args arbitrary Object to print
    #
    # @return [nil] prints to IO, returns nothing
    def print(*args)
      ap(*args)
    end
  end

  register :amazing_print, AmazingPrint
end

# Configure Tapp to use our custom printer and report caller
Tapp.configure do |config|
  config.report_caller   = true
  config.default_printer = :amazing_print
end
