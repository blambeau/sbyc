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
  
end # module SByC

require 'sbyc/errors'
require 'sbyc/system'
require 'sbyc/type'
require 'sbyc/value'
require 'sbyc/typeimpl/heading'
require 'sbyc/typeimpl/constraint_able'
require 'sbyc/typeimpl/builtin_type'
require 'sbyc/typeimpl/scalar_type'

require 'sbyc/ext/object'

require 'sbyc/core/boolean'
require 'sbyc/core/wrappers'
