$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sbyc/engine'

# Creates a type for positive integers
Natural = Fixnum.such_that{|i| i > 0}

# Creates rectangle and square types
Rectangle = ScalarType(:width => Natural, :height => Natural)
# Square    = Rectangle.such_that{|r| r.width == r.height}
# 
# # Create a rectangle instance
# r = Rectangle[:width => 10, :height => 20]
# assert Rectangle === r
# assert !(Square === r) 
# 
# # Creates a new rectangle (which is actually a square) by copy-and-modify
# r2 = r.update(:height => 10)
# assert Rectangle === r2
# assert Square === r2
# 
# # Creates a new square which is equivalent
# r3 = Square[:width => 10, :height => 10]
# assert Rectangle === r3
# assert r2 == r3
# 
# assert_raise(::SByC::TypeError) {
#   r4 = Square[:width => 10, :height => 20]
# }


Square = ScalarType(Rectangle, :length => Natural) do
  constraint(Rectangle) {|r| r.width == r.height }
  representation(Rectangle => Square){ {:length => r.width} }
  representation(Square => Rectangle){ {:width => s.height, :height => s.length} }
end
s = Square[:length => 10]
assert Square === s
assert Rectangle === s
assert s.length == 10
assert s.width == 10