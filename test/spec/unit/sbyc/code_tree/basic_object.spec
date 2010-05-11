require File.expand_path('../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::BasicObject" do

  subject { ::SByC::CodeTree::BasicObject.new }

  describe "should not have access to Kernel methods" do
    specify {
      proc { subject.instance_eval{ puts "hello" } }.should raise_error(NoMethodError)
    }
  end
  
  describe "should not have a to_s method" do
    specify {
      proc { subject.respond_to?(:to_s).should be_false}
    }
  end
  
  describe "should not have an inspect method" do
    specify {
      proc { subject.respond_to?(:inspect).should be_false}
    }
  end
  
end