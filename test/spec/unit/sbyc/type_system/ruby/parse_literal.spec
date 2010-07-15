require File.expand_path('../../../../../spec_helper', __FILE__)
require 'sbyc/type_system/ruby'

describe "TypeSystem::Ruby#parse_literal" do
  
  describe "when called on a String value" do
    subject{ TypeSystem::Ruby.parse_literal("'string'") }
    it{ should == 'string' }
  end
  
  describe "when called on a Fixnum value" do
    subject{ TypeSystem::Ruby.parse_literal('10') }
    it{ should == 10 }
  end
  
  describe "when called on true" do
    subject{ TypeSystem::Ruby.parse_literal('true') }
    it{ should == true }
  end
  
  describe "when called on false" do
    subject{ TypeSystem::Ruby.parse_literal('false') }
    it{ should == false }
  end
  
end
