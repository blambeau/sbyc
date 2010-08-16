require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::Signature.make_operator_call" do
  
  subject{ sign.make_operator_call(proc, args) }
  
  describe "on a monadic signature" do
    let(:sign){ SByC::R::Operator::Signature::regular{ R::Boolean } }
    let(:proc){ lambda{|value| "Hello #{value}"} }
    let(:args){ [true] }
    
    it{ should == "Hello true" }
  end

  describe "on a dyadic signature" do
    let(:sign){ SByC::R::Operator::Signature::regular{ (seq R::String, R::Integer) } }
    let(:proc){ lambda{|s, t| s*t} }
    let(:args){ ["hello", 2] }
    
    it{ should == "hellohello" }
  end
  
  describe "on a star signature" do
    let(:sign){ SByC::R::Operator::Signature::regular{ (star R::String) } }
    let(:proc){ lambda{|strs| strs.join(" ")} }
    let(:args){ ["hello", "world"] }
    
    it{ should ==  "hello world" }
  end
  
  describe "on a star signature" do
    let(:sign){ SByC::R::Operator::Signature::regular{ (plus R::String) } }
    let(:proc){ lambda{|strs| strs.join(" ")} }
    let(:args){ ["hello", "world"] }
    
    it{ should ==  "hello world" }
  end
  
  describe "on a somewhat complex signature" do
    let(:sign){ SByC::R::Operator::Signature::regular{ (seq R::Symbol, (plus R::String)) } }
    let(:proc){ lambda{|name, args| [name, args.join(' ')]} }
    let(:args){ [:name, "hello", "world"] }
    
    it{ should ==  [:name, "hello world"] }
  end
  
end