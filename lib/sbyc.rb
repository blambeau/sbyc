require 'sbyc/core_ext'
require 'sbyc/code_tree'
require 'sbyc/system'
module SByC
  class TypeCheckingError < StandardError; end

  # Version
  VERSION = "0.0.1".freeze

  # Parses some code and returns a code tree.
  def parse(code = nil, &block)
    ::TypeSys::CodeTree::parse(code, &block)
  end
  module_function :parse
  
  # Applies type checking to a code
  def type_check(system, code = nil, &block)
    system.type_check(code, block)
  end
  module_function :type_check
  
  # Parses some code and returns a code tree.
  def to_ruby_code(system, code = nil, &block)
    system.to_ruby_code(code, block)
  end
  module_function :to_ruby_code
  
end
