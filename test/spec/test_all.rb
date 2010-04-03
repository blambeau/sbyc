$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
require 'sbyc'
require 'spec/autorun'
#require File.join(File.dirname(__FILE__), '..', 'fixtures')
test_files = Dir[File.join(File.dirname(__FILE__), '**/*.spec')]
test_files.each { |file|
  ::Kernel.load(file) 
}

