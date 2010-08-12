require File.expand_path('../../fixtures', __FILE__)
describe "R::Alpha's name" do
  
  it "should return SByC::R::Alpha" do
    R::Alpha.name.should == "SByC::R::Alpha"
  end
  
end
