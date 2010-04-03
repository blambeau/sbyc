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
require 'sbyc/variable'
require 'sbyc/system'
require 'sbyc/builtin'
extend SByC::System