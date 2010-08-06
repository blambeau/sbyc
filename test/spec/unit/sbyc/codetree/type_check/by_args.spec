require File.expand_path('../../../../../spec_helper', __FILE__)
describe "CodeTree::AstNode#type_check" do
  
  it "should work on valid expressions" do
    args = {:x => true, :y => false}
    CodeTree::parse{ x }.type_check(args).should == R::Boolean
    CodeTree::parse{ x & y }.type_check(args).should == R::Boolean
  end
  
  it "should raise TypeCheck error on invalid expressions" do
    args = {:x => true}
    lambda{ CodeTree::parse{ x & y }.type_check(args) }.should raise_error(SByC::TypeCheckError)
  end
  
end