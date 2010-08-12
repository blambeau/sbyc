require File.expand_path('../../fixtures', __FILE__)
describe "R::Alpha's sbyc_domain method" do
  
  it "should return SByC::R::Domain" do
    R::Boolean.sbyc_domain.should == R::Domain
    R::Alpha.sbyc_domain.should == R::Domain
  end
  
end
