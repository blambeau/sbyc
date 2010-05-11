require File.expand_path('../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::BasicObject" do

  subject { ::SByC::CodeTree::BasicObject.new }

  describe "should not have access to Kernel methods" do
    specify {
      proc { subject.instance_eval{ puts "hello" } }.should raise_error(NoMethodError)
    }
  end
  
end