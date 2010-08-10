require File.expand_path('../../fixtures', __FILE__)
describe "R::Numeric's super domains" do
  
  it "should include Alpha" do
    R::Numeric.has_super_domain?(R::Alpha).should be_true
  end
  
end