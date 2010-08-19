require File.expand_path('../../fixtures', __FILE__)
describe "R::Alpha::domain_of" do
  
  let(:R){ SByC::Fixtures::R }
  
  SByC::Fixtures::R::BOOLEANS.each{|i|
    it "should recognize #{i}" do
      R::Alpha::domain_of(i).should == R::Boolean
    end
  }
  
  SByC::Fixtures::R::INTEGERS.each{|i|
    it "should recognize #{i}" do
      R::Alpha::domain_of(i).should == R::Integer
    end
  }
  
  SByC::Fixtures::R::FLOATS.each{|i|
    it "should recognize #{i}" do
      R::Alpha::domain_of(i).should == R::Float
    end
  }
  
  SByC::Fixtures::R::STRINGS.each{|i|
    it "should recognize #{i}" do
      R::Alpha::domain_of(i).should == R::String
    end
  }
  
  SByC::Fixtures::R::REGEXPS.each{|i|
    it "should recognize #{i}" do
      R::Alpha::domain_of(i).should == R::Regexp
    end
  }
  
  SByC::Fixtures::R::SYMBOLS.each{|i|
    it "should recognize #{i}" do
      R::Alpha::domain_of(i).should == R::Symbol
    end
  }
  
  it "should raise a TypeError when the value is unknown" do
    lambda{ R::Alpha::domain_of(Object.new) }.should raise_error(SByC::Error)
  end
    
end