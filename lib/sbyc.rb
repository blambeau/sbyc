module SByC
  
  # Current system version
  VERSION = "0.0.1".freeze
  
  # Ruby types considered as builtin types
  BUILTIN_TYPES = [::String, ::Fixnum, ::Float, ::Time]
  
  # Executes a .sbyc file
  def execute(file)
    Kernel.load("#{file}.sbyc")
  end
  module_function :execute
  
  def Integer(i)
    ::SByC::Integer[i]
  end
  
end # module SByC

require 'sbyc/errors'
require 'sbyc/system'
require 'sbyc/type'
require 'sbyc/value'
require 'sbyc/typeimpl/constraint_able'
require 'sbyc/typeimpl/builtin_type'
require 'sbyc/typeimpl/scalar_type'
require 'sbyc/typeimpl/boolean'
require 'sbyc/ext/core'
::SByC::execute("sbyc/typeimpl/integer")