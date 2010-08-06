require File.expand_path('../../fixtures', __FILE__)
describe "R::Domain.values" do
  
  it "should have domains only" do
    SByC::Typing::R::Domain.values.each{|d| 
      d.domain.should == SByC::Typing::R::Domain
      R::Domain.is_value?(d).should be_true
    }
  end
  
end