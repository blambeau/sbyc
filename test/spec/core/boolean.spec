require 'sbyc'
describe ::Boolean do
  
  it "should provide true and false constants" do
    (::Boolean === Boolean::TRUE).should be_true
    (::Boolean === Boolean::FALSE).should be_true
  end
  
  it "should recognize true and false values" do
    (::Boolean === true).should be_true
    (::Boolean === false).should be_true
  end
  
  it "should reject other values" do
    (::Boolean === "bla").should be_false
    (::Boolean === nil).should be_false
  end
  
  it "should be such that values are correctly recognized" do
    true.belongs_to?(::Boolean).should be_true
    false.belongs_to?(::Boolean).should be_true
    nil.belongs_to?(::Boolean).should be_false
    "blabla".belongs_to?(::Boolean).should be_false
  end  
  
  it "should be constrainable" do
    true_type = ::Boolean.such_that{|t| t == true }
    true_type[true].should == true
    lambda{ true_type[false] }.should raise_error(::SByC::TypeError)
    true.belongs_to?(::Boolean).should be_true
    true.belongs_to?(true_type).should be_true
    false.belongs_to?(true_type).should be_false
    "blabla".belongs_to?(true_type).should be_false
  end
  
end
