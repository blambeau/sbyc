require File.expand_path('../../fixtures', __FILE__)
describe "R::Integer's super domains" do
  
  it "should include Numeric" do
    R::Integer.has_super_domain?(R::Numeric).should be_true
  end
  
  it "should include Alpha" do
    R::Integer.has_super_domain?(R::Alpha).should be_true
  end
  
end