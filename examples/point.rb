$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sbyc/engine'

# Make some type definition first
::SByC::System.typedef do

  # Creates a Natural type for natural numbers
  Natural = Fixnum.such_that{|i| i > 0}
  
  # Creates an Angle type
  Angle = ScalarType() {
    representation :Degree, :degree => Float
    representation :Radian, :radian => Float
    converter(:Degree => :Radian){|from,to| to.radian = from.degree * (Math::PI / 180.0) }
    converter(:Radian => :Degree){|from,to| to.degree = from.radian * (180.0 / Math::PI) }
  }
  
  # Creates the notion of length
  Length = ScalarType(:length => Natural)
  
  # Creates a 2D point
  Point = ScalarType() {
    representation :Cartesian, :x      => Fixnum, :y     => Fixnum
    representation :Polar,     :radius => Length, :theta => Angle
    converter(:Polar => :Cartesian) {|from, to|
      to.x, to.y = from.radius.length * Math.cos(from.theta.radian), from.radius.length * Math.sin(from.theta.radian)
    }
    converter(:Cartesian => :Polar) {|from, to|
      to.radius, to.theta = Math.sqrt(from.x**2 + from.y**2), Math.atan(from.x.radian / from.y.radian)
    }
  }
end

puts Length(1)
puts Length(:length => 1)
puts Point::Cartesian(:x => 12, :y => 15)
puts Point::Polar(:radius => Length(1), :theta => Angle::Degree(45.0))
