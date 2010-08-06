require File.expand_path('../../fixtures', __FILE__)
describe "R::Boolean.is_value?" do
  
  SByC::Fixtures::R::BOOLEANS.each{|i|
    it "should accept #{i}" do
      R::Boolean.is_value?(i).should == true
    end
  }
  
  [nil, ''].each do |bad|
    it "should accept #{bad}" do
      R::Boolean.is_value?(bad).should == false
    end
  end   

end
