require File.expand_path('../../fixtures', __FILE__)
describe "R::domain_of" do
  
  let(:R){ SByC::Fixtures::R }
  
  SByC::Fixtures::R::BOOLEANS.each{|i|
    it "should recognize #{i}" do
      R.domain_of(i).should == R::Boolean
    end
  }
  
  SByC::Fixtures::R::INTEGERS.each{|i|
    it "should recognize #{i}" do
      R.domain_of(i).should == R::Integer
    end
  }
  
  SByC::Fixtures::R::FLOATS.each{|i|
    it "should recognize #{i}" do
      R.domain_of(i).should == R::Float
    end
  }
  
  SByC::Fixtures::R::STRINGS.each{|i|
    it "should recognize #{i}" do
      R.domain_of(i).should == R::String
    end
  }
  
  SByC::Fixtures::R::REGEXPS.each{|i|
    it "should recognize #{i}" do
      R.domain_of(i).should == R::Regexp
    end
  }
  
  SByC::Fixtures::R::SYMBOLS.each{|i|
    it "should recognize #{i}" do
      R.domain_of(i).should == R::Symbol
    end
  }
  
  it "should raise a TypeError when the value is unknown" do
    lambda{ R.domain_of(Object.new) }.should raise_error(SByC::TypeError)
  end
  
  it "should have a type_of alias" do
    R.type_of(true).should == R::Boolean
  end
    
end