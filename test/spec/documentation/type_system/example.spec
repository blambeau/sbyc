require File.expand_path('../../../spec_helper', __FILE__)
require 'sbyc/type_system/ruby'
describe "Gh-Pages documentation: type_system/home.redcloth" do
  
  describe "What is said in README" do
    specify{
      TypeSystem::Ruby::type_of(-125).should == Fixnum
      # => Fixnum

      lit = TypeSystem::Ruby::to_literal(-125).should == "-125"
      # => "-125"

      TypeSystem::Ruby::parse_literal("-125").should == -125
      # => -125

      TypeSystem::Ruby::coerce('-125', Integer).should == -125
      # => -125
    }
  end
  
end