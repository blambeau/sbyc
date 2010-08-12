require File.expand_path('../../fixtures', __FILE__)
describe "R::Domain's name" do
  
  it "should return SByC::R::Domain" do
    R::Domain.name.should == "SByC::R::Domain"
  end
  
end
