require File.expand_path('../../fixtures', __FILE__)
describe "R::Boolean.name" do
  
  it "should be Boolean" do
    R::Boolean.name.should == "SByC::R::Boolean"
  end
  
end