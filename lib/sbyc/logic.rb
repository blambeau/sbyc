require 'sbyc/logic/formula'
require 'sbyc/logic/term'
require 'sbyc/logic/false'
require 'sbyc/logic/true'
require 'sbyc/logic/variable'
require 'sbyc/logic/finite'
require 'sbyc/logic/ordered'
require 'sbyc/logic/parser'
module Logic
  
  # All logic
  TRUE = Logic::True.new
  
  # False logic
  FALSE = Logic::False.new
  
  # Parses a logical expression and returns a formula
  def parse(type_system, &block)
    Logic::Parser.new(type_system).parse(block)
  end
  
end