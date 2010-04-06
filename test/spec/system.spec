require 'sbyc'
describe ::SByC::System do
  
  it "should provide a type selector function for Boolean" do
    ::SByC::System::Boolean(true).should == true
    ::SByC::System::Boolean(false).should == false
    lambda { ::SByC::System::Boolean("blabla") }.should raise_error(::SByC::TypeError)
  end
  
  it "should provide a type selector function for wrapped types" do
    ::SByC::System::Fixnum(12).should == 12
    lambda { ::SByC::System::Fixnum("blabla") }.should raise_error(::SByC::TypeError)
  end
  
end