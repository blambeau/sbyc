require File.expand_path('../../fixtures', __FILE__)
describe "R::Domain.domain" do
  
  it "should be Class" do
    SByC::Typing::R::Domain.domain.should == ::Class
  end
  
end