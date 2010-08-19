require File.expand_path('../../../../../spec_helper', __FILE__)
describe "CodeTree::AstNode#type_check" do
  
  it "should work on valid boolean expressions" do
    pending('feature not supported anymore'){
      args = {:x => true, :y => false}
      CodeTree::type_check(args){ x }.should == R::Boolean
      CodeTree::type_check(args){ x & y }.should == R::Boolean
    }
  end
  
  it "should work on valid string expressions" do
    pending('feature not supported anymore'){
      args = {:x => "hello"}
      CodeTree::type_check(args){ (empty? x) }.should == R::Boolean
      CodeTree::type_check(args){ (length x) }.should == R::Integer
      CodeTree::type_check(args){ (reverse x) }.should == R::String
    }
  end
  
  it "should raise TypeCheck error on invalid expressions" do
    pending('feature not supported anymore'){
      args = {:x => true}
      lambda{ CodeTree::type_check(args){ x & y } }.should raise_error(SByC::TypeCheckError)
    }
  end
  
end