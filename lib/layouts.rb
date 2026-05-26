Dir[File.join(__dir__, "layouts", "*.rb")].each { |f| require f }

# Registry of known Google carousel layout adapters.
module Layouts
  def self.klasses
    constants
      .map { |c| const_get(c) }
      .select { |c| c.is_a?(Class) && c.method_defined?(:item_selector, false) }
  end

  def self.detect(doc)
    klasses.map(&:new).find { |l| doc.css(l.item_selector).any? }
  end
end
