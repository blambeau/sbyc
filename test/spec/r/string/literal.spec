require File.expand_path('../../fixtures', __FILE__)
describe "R::String.parse_literal" do
  
  SByC::Fixtures::R::STRINGS.each{|i|
    it "should accept #{i.inspect}" do
      R::String::parse_literal(R::String::to_literal(i)).should == i
    end
  }
  
  File.readlines(File.expand_path('../strings.txt', __FILE__)).collect{|s| s.strip}.each do |str|
    it "should accept #{str.inspect}" do
      expected = Kernel.eval(str)
      R::String::parse_literal(str).should == expected
      R::String::parse_literal(R::String::to_literal(expected)).should == expected
    end
  end
  
  [nil, '', 'hello', "'hello O'Neil'", '"hello O"Neil"'].each{|bad|
    it "should raise an error on #{bad.inspect}" do
      lambda{ R::String.parse_literal(bad) }.should raise_error(SByC::TypeError)
    end
  }
  
end
