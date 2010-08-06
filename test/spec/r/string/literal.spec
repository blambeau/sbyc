require File.expand_path('../../../spec_helper', __FILE__)
describe "R::String.parse_literal" do
  
  File.readlines(File.expand_path('../strings.txt', __FILE__)).collect{|s| s.strip}.each do |str|
    it "should accept #{str}" do
      expected = Kernel.eval(str)
      R::String::parse_literal(str).should == expected
      R::String::parse_literal(R::String::to_literal(expected)).should == expected
    end
  end
  
  [nil, '', 'hello', "'hello O'Neil'", '"hello O"Neil"'].each{|bad|
    it "should raise an error when called on bad literal #{bad}" do
      lambda{ R::String.parse_literal(bad) }.should raise_error(SByC::TypeError)
    end
  }
  
end
