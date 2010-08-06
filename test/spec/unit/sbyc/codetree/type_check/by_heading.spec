require File.expand_path('../../../../../spec_helper', __FILE__)
describe "CodeTree::AstNode#type_check" do
  
  it "should work on valid expressions" do
    args = {:x => R::Boolean, :y => R::Boolean}
    CodeTree::type_check_by_heading(args){ x }.should == R::Boolean
    CodeTree::type_check_by_heading(args){ x & y }.should == R::Boolean
  end
  
  it "should raise TypeCheck error on invalid expressions" do
    args = {:x => R::Boolean}
    lambda{ CodeTree::type_check_by_heading(args){ x & y } }.should raise_error(SByC::TypeCheckError)
  end
  
end