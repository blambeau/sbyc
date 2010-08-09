require File.expand_path('../../fixtures', __FILE__)
describe "R::Domain.domain" do
  
  it "should be Class" do
    R::Domain.domain.should == ::Class
  end
  
end