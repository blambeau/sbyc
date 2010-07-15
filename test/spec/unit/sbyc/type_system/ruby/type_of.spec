require File.expand_path('../../../../../spec_helper', __FILE__)
require 'sbyc/type_system/ruby'

describe "TypeSystem::Ruby#type_of" do
  
  describe "when called on a String value" do
    subject{ TypeSystem::Ruby.type_of("string") }
    it{ should == String }
  end
  
  describe "when called on a Fixnum value" do
    subject{ TypeSystem::Ruby.type_of(10) }
    it{ should == Fixnum }
  end
  
end
