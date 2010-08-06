require File.expand_path('../fixtures', __FILE__)
describe "R::literal methods" do
  
  let(:R){ SByC::Fixtures::R }
  
  SByC::Fixtures::R.each_value{|i|
    it "should correctly handle literal #{i}" do
      next if i == R::Domain
      R::to_literal(i).should be_kind_of(String)
      R::parse_literal(R::to_literal(i)).should == i
    end
  }
  
  it "should raise a TypeError if the literal is unknown" do
    lambda{ R::to_literal(Object.new) }.should raise_error(SByC::TypeError)
    lambda{ R::parse_literal('strange thing') }.should raise_error(SByC::TypeError)
  end
  
end