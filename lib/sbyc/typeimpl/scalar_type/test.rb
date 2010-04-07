$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', '..', '..'))
require 'sbyc'
require 'sbyc/engine'

# class Angle
#   extend(::SByC::ScalarType::ClassMethods)
#   include(::SByC::ScalarType::InstanceMethods)
# end
# Angle.__add_possible_representation(:Degree, ::SByC::Heading[:degree => Float])
# Angle.__add_possible_representation(:Radian, ::SByC::Heading[:radian => Float])
# Angle.__add_conversion(:Degree, :Radian){|from, to| 
#   to.radian = from.degree * (Math::PI / 180.0) 
# }
# Angle.__add_conversion(:Radian, :Degree){|from, to| 
#   to.degree = from.radian * (180.0 / Math::PI) 
# }
# a = Angle::Degree[:degree => 45.0]
# b = Angle::Radian[:radian => 0.785398163397448]

# class Length
#   extend(::SByC::ScalarType::ClassMethods)
#   include(::SByC::ScalarType::InstanceMethods)
# end
# Length.__add_possible_representation(:CM, SByC::Heading[:cm => Float])
# Length.__add_possible_representation(:Inch, SByC::Heading[:inch => Float])
# Length.__add_conversion(:CM, :Inch){|from,to| to.inch = from.cm/2.54}
# Length.__add_conversion(:Inch, :CM){|from,to| to.cm = from.inch*2.54}
# a = Length::CM[:cm => 2.54]
# b = Length::Inch[:inch => 1.0]
# puts a == b
# puts "#{a} : #{a.cm} and #{a.inch}"
# puts "#{b} : #{b.cm} and #{b.inch}"

Length = ScalarType() {
  representation(:CM,   :cm => Float)
  representation(:Inch, :inch => Float)
  converter(:CM => :Inch){|from,to| to.inch = from.cm/2.54}
  converter(:Inch => :CM){|from,to| to.cm = from.inch*2.54}
}
a = Length::CM(2.54)
b = Length::Inch(1.0)
puts a == b

Angle = ScalarType() {
  representation :Degree, :degree => Float
  representation :Radian, :radian => Float
  converter(:Degree => :Radian){|from,to| to.radian = from.degree * (Math::PI / 180.0) }
  converter(:Radian => :Degree){|from,to| to.degree = from.radian * (180.0 / Math::PI) }
}
a = Angle::Degree(45.0)
b = Angle::Radian(Math::PI/4)
puts a == b

# x = 45.0*(Math::PI / 180.0)
# y = 0.785398163397448
# puts "#{x.class} : #{"%.40f" % x}"
# puts "#{y.class} : #{"%.40f" % y}"
# puts 45.0*(Math::PI / 180.0) == 0.785398163397448
