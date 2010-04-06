$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sbyc/engine'

# Creates a type for positive integers
Natural = Fixnum.such_that{|i| i > 0}

# Creates rectangle and square types
Rectangle = ScalarType(:width => Natural, :length => Natural)
Square    = Rectangle.such_that{|r| r.width == r.length}

# Create a rectangle instance
r = Rectangle[:width => 10, :length => 20]
assert Rectangle === r
assert !(Square === r) 

# Creates a new rectangle (which is actually a square) by copy-and-modify
r2 = r.update(:length => 10)
assert Rectangle === r2
assert Square === r2