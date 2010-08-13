require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::PairedSignature.make_operator_call" do
  
  let(:sign){ R::Operator::Signature::paired(R::Symbol, R::Numeric) }
  let(:callable){ lambda{|x| x} }
  subject{ sign.make_operator_call(callable, args) }
  
  describe "it should work on empty" do
    let(:args){ [] }
    it{ should == {} }
  end
  
  describe "it should work on correct singleton" do
    let(:args){ [:hello, 12] }
    it{ should == {:hello => 12} }
  end
  
  describe "it should work on correct varargs" do
    let(:args){ [:hello, 12, :world, 14.0] }
    it{ should == {:hello => 12, :world => 14.0} }
  end
  
end