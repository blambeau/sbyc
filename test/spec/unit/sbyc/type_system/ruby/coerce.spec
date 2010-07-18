require File.expand_path('../../../../../spec_helper', __FILE__)
require 'sbyc/type_system/ruby'

describe "TypeSystem::Ruby#coerce" do
  
  ##################################################################################
  ### SAFE CLASSES REPRESENTORS
  ##################################################################################
  
  safe_representors = {
    NilClass   => [ nil ],
    TrueClass  => [ true ],
    FalseClass => [ false ],
    Fixnum     => [ -(2**(0.size * 8 - 2)), -1, 0, 1, 10, (2**(0.size * 8 - 2) - 1)],
    Bignum     => [ -(2**(0.size * 8 - 2)) - 1, (2**(0.size * 8 - 2)) ],
    Float      => [ -0.10, 0.0, 0.10 ],
    String     => ['', 'hello'],
    Symbol     => [ :hello, :"s-b-y-c", :"12" ],
    Class      => [ Integer, ::Struct::Tms ],
    Module     => [ Kernel, TypeSystem, TypeSystem::Ruby ],
    Regexp     => [ /a-z/, /^$/, /\s*/, /[a-z]{15}/ ]
  }
  
  safe_representors.each_pair do |clazz, values|
    values.each do |value|
      describe "When coercing #{value} to a #{clazz}" do
        it "should return #{value}" do
          str = value.kind_of?(Regexp) ? value.inspect[1..-2] : value.to_s
          TypeSystem::Ruby::coerce(str, clazz).should == value
        end  
      end
    end
  end 


  ##################################################################################
  ### User defined objects
  ##################################################################################
  class TypeSystem::Ruby::Bar
    attr_accessor :id
    def initialize(id = 1); @id = id; end
    def ==(other); other.kind_of?(TypeSystem::Ruby::Bar) and other.id == id; end
    def self.parse(str)
      TypeSystem::Ruby::Bar.new(TypeSystem::Ruby::coerce(str, Integer))
    end
    def inspect
      id.inspect
    end
  end
  
  describe "when called with a user-defined class that respond to parse" do
    
    subject{ TypeSystem::Ruby::coerce(str, TypeSystem::Ruby::Bar) }

    describe "when given a valid value" do
      let(:value){ TypeSystem::Ruby::Bar.new(10) }
      let(:str){ value.inspect }
      it{ should == value }
    end
    
    describe "when given an invalid values" do
      let(:str){ "hello" }
      specify{
        lambda{ subject }.should raise_error(TypeSystem::CoercionError)
      }
    end
    
  end
  
  
  ##################################################################################
  ### Invalid values
  ##################################################################################
  
  invalid_values = {
    NilClass   => [ "hello", "false" ],
    TrueClass  => [ "false", "nil" ],
    FalseClass => [ "true", "nil" ],
    Fixnum     => [ "hello", "1hello", "hello1", "1.0" ],
    Bignum     => [ "hello", "1hello", "hello1", "1.0" ],
    Float      => [ "hello", "1hello", "hello1", "1.0qsjh" ],
    Class      => [ "hello" ],
    Module     => [ "hello" ],
    Regexp     => [ "{}" ]
  }
  
  invalid_values.each_pair do |clazz, values|
    values.each do |value|
      describe "When coercing #{value} to a #{clazz}" do
        it "should raise an exception" do
          lambda{ TypeSystem::Ruby::coerce(value, clazz) }.should raise_error(TypeSystem::CoercionError)
        end  
      end
    end
  end 
  
end
