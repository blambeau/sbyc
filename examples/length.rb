$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sbyc/engine'

Length = ::SByC::System::ScalarType(:cm => Float)
::SByC::System.install_shortcuts

assert_equal 12.0, ::SByC::System::Length(12.0).cm
