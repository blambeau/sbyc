require 'sbyc'
describe ::SByC::BuiltinType do
  
  it "should provide a type selector" do
    Fixnum[12].should == 12
    String["blabla"].should == "blabla"
  end
  
  it "should allow subtyping by constraint" do
    posint = Fixnum.such_that{|i| i > 10}
    posint.is_a?(Class).should be_true
    posint.supertype.should == Fixnum
    (posint === 12).should be_true
    (posint === -1).should be_false
    posint[12].should == 12
    lambda{ posint[-1] }.should raise_error(::SByC::TypeError)
  end

  it "should provide a way to check values belonging to the type" do
    Fixnum.include_value?(12).should be_true
    Fixnum.include_value?("blabla").should be_false
    posint = Fixnum.such_that{|i| i > 10}
    posint.include_value?(-12).should be_false
  end
  
  it "should provide a reversed way to check values belonging to the type" do
    posint = Fixnum.such_that{|i| i > 10}
    12.belongs_to?(Fixnum).should be_true
    12.belongs_to?(posint).should be_true
    -12.belongs_to?(posint).should be_false
    "blabla".belongs_to?(posint).should be_false
  end

end