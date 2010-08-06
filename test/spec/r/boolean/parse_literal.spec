require File.expand_path('../../../spec_helper', __FILE__)
describe "R::Boolean.parse_literal" do
  
  describe "when called on valid values" do
    subject{ R::Boolean.parse_literal(literal) }
  
    describe "when called on 'false'" do
      let(:literal){ 'false' }
      it{ should == false }
    end
  
    describe "when called on '  false '" do
      let(:literal){ '  false ' }
      it{ should == false }
    end
  
    describe "when called on 'true'" do
      let(:literal){ 'true' }
      it{ should == true }
    end
  
    describe "when called on '  true  '" do
      let(:literal){ ' true  ' }
      it{ should == true }
    end
  end
  
  [nil, 'truef', 'fals' ''].each{|bad|
    it "should raise an error when called on bad literal #{bad}" do
      lambda{ R::Boolean.parse_literal(bad) }.should raise_error(SByC::TypeError)
    end
  }
  
end
