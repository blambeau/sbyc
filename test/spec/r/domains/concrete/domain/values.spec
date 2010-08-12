require File.expand_path('../../fixtures', __FILE__)
describe "R::Domain.values" do
  
  it "should have expected domains" do
    R::Domain.values.include?(R::Boolean).should be_true
  end
  
  it "should have domains only" do
    R::Domain.values.each{|d| 
      d.sbyc_domain.should == R::Domain
      R::Domain.is_value?(d).should be_true
    }
  end
  
end