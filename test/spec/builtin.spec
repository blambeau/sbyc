require 'sbyc'
describe ::SByC::BuiltinType do
  
  it "should provide a type selector" do
    Fixnum[12].should == 12
    String["blabla"].should == "blabla"
  end
  
  it "should allow subtyping by constraint" do
    posint = Fixnum.such_that{|i| i > 10}
    posint.is_a?(Class).should be_true
    (posint === 12).should be_true
    (posint === -1).should be_false
    posint[12].should == 12
    lambda{ posint[-1] }.should raise_error(::SByC::TypeError)
  end
  
end