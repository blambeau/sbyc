require File.expand_path('../../../../../spec_helper', __FILE__)
require 'sbyc/type_system/ruby'

describe "TypeSystem::Ruby::Boolean" do
  
  subject{ TypeSystem::Ruby::Boolean }
  
  it { should === true }
  
  it { should === false }

  it { should_not === nil }
  
  it "should be coercable easily" do
    SByC::TypeSystem::Ruby::coerce(subject, Module).should == subject
    SByC::TypeSystem::Ruby::coerce(subject.to_s, Module).should == subject
  end
  
end
