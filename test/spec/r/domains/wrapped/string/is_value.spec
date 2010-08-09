require File.expand_path('../../fixtures', __FILE__)
describe "R::String.is_value?" do
  
  SByC::Fixtures::R::STRINGS.each{|i|
    it "should accept #{i.inspect}" do
      R::String.is_value?(i).should == true
    end
  }
  
  [nil, 12].each do |bad|
    it "should reject #{bad.inspect}" do
      R::String.is_value?(bad).should == false
    end
  end
  
end
