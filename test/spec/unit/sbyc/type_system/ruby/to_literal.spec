require File.expand_path('../../../../../spec_helper', __FILE__)
require 'sbyc/type_system/ruby'

describe "TypeSystem::Ruby#to_literal" do
  
  safe_representors = {
    NilClass   => [ nil ],
    TrueClass  => [ true ],
    FalseClass => [ false ],
    Fixnum     => [ -(2**(0.size * 8 - 2)), -1, 0, 1, 10, (2**(0.size * 8 - 2) - 1)],
    Bignum     => [ -(2**(0.size * 8 - 2)) - 1, (2**(0.size * 8 - 2)) ],
    Float      => [ -0.10, 0.0, 0.10 ],
    String     => ['', 'hello']
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
  
  [1.0/0, -1.0/0].each do |value|
    describe "when called on special value #{value}" do
      subject{ TypeSystem::Ruby::parse_literal(TypeSystem::Ruby::to_literal(value)) }
      it{ should == value }
    end
  end
  
end
