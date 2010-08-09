require File.expand_path('../../../fixtures', __FILE__)
describe "R::Domain.values" do
  
  it "should have expected domains" do
    R::Domain.values.include?(R::Boolean).should be_true
  end
  
  it "should have domains only" do
    R::Domain.values.each{|d| 
      if d == R::Domain
        d.domain.should == ::Class
      else
        d.domain.should == R::Domain
      end
      R::Domain.is_value?(d).should be_true
    }
  end
  
end