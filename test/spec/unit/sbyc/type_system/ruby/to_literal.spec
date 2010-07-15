require File.expand_path('../../../../../spec_helper', __FILE__)
require 'sbyc/type_system/ruby'

describe "TypeSystem::Ruby#to_literal" do
  
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
  
  TypeSystem::Ruby::Methods::SAFE_LITERAL_CLASSES.keys.each do |clazz|
    describe("SAFE_LITERAL_CLASS #{clazz} is covered by spec tests") do
      subject{ safe_representors.key?(clazz) }
      it{ should be_true }
    end
  end
  
  safe_representors.each_pair{|clazz, values|
    values.each do |value|
      describe("Safe representor #{value} is of good type #{clazz} natively") do
        subject{ value.class }
        it{ should == clazz }
      end

      describe("Safe representor #{value} is of good type #{clazz} through Ruby::type_of") do
        subject{ TypeSystem::Ruby::type_of(value) }
        it{ should == clazz }
      end

      describe("to_literal on safe representor #{clazz} / #{value} is equal to inspect") do
        subject{ TypeSystem::Ruby::to_literal(value) }
        it{ should == value.inspect }
      end

      describe("to_literal invariant is respected on safe representor #{clazz} / #{value}") do
        subject{ TypeSystem::Ruby::parse_literal(TypeSystem::Ruby::to_literal(value)) }
        it{ should == value }
      end
    end
  }
  
  ##################################################################################
  ### SPECIAL VALUES
  ##################################################################################
  
  special_values = [
    1.0/0, -1.0/0,
    Time::parse(Time.now.inspect), Date::parse(Date.today.to_s)
  ]
  
  special_values.each{|value|
    describe("When called on special value #{value}") do
      subject{ TypeSystem::Ruby::parse_literal(TypeSystem::Ruby::to_literal(value)) }
      it{ should == value }
    end
  }
  
  ##################################################################################
  ### ARRAY AND HASH
  ##################################################################################
  
  describe "When called on an array with safe class instances" do
    let(:value){ (safe_representors.values + special_values).flatten }
    subject{ TypeSystem::Ruby::parse_literal(TypeSystem::Ruby::to_literal(value)) }
    it{ should == value }
  end

  describe "When called on a hash with safe class instances" do
    let(:value){ safe_representors }
    subject{ TypeSystem::Ruby::parse_literal(TypeSystem::Ruby::to_literal(value)) }
    it{ should == value }
  end


  ##################################################################################
  ### User defined objects
  ##################################################################################
  
  class TypeSystem::Ruby::Foo
    attr_accessor :id
    def initialize(id = 1); @id = id; end
    def ==(other); other.kind_of?(TypeSystem::Ruby::Foo) and other.id == id; end
    def inspect
      "TypeSystem::Ruby::Foo.new(#{id.inspect})"
    end
  end
  
  non_failing_fallbacks = [:inspect, :marshal]
  non_failing_fallbacks.each do |fallback|
    describe "When called on a user-defined object with a #{fallback.inspect} fallback option" do
      let(:value){ TypeSystem::Ruby::Foo.new(10) }
      subject{ TypeSystem::Ruby::parse_literal(TypeSystem::Ruby::to_literal(value, :fallback => fallback)) }
      it{ should == value }
    end
  end
  
  describe 'When called on a user-defined object with a :fail fallback option' do
    let(:value){ TypeSystem::Ruby::Foo.new(10) }
    subject{ Kernel::lambda{ TypeSystem::Ruby::to_literal(value, :fallback => :fail) } }
    it{ should raise_error(TypeSystem::NoSuchLiteralError) }
  end
  
end
