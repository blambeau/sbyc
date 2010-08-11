require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::Signature.make_operator_call" do
  
  subject{ sign.make_operator_call(proc, args) }
  
  describe "on a monadic signature" do
    let(:sign){ SByC::R::Operator::Signature.coerce([R::Boolean]) }
    let(:proc){ lambda{|value| "Hello #{value}"} }
    let(:args){ [true] }
    
    it{ should == "Hello true" }
  end

  describe "on a dyadic signature" do
    let(:sign){ SByC::R::Operator::Signature.coerce([R::String, R::Integer]) }
    let(:proc){ lambda{|str, nb| str*nb} }
    let(:args){ ["hello", 2] }
    
    it{ should == "hellohello" }
  end
  
end