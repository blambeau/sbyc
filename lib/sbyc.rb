module SByC
  
  # Current system version
  VERSION = "0.0.1".freeze
  
  # Executes a .sbyc file
  def execute(file)
    Kernel.load("#{file}.sbyc")
  end
  module_function :execute
  
end # module SByC

require 'sbyc/errors'
require 'sbyc/system'
require 'sbyc/type'
require 'sbyc/typeimpl/boolean'
require 'sbyc/typeimpl/scalar_type'
::SByC::execute("sbyc/typeimpl/integer")