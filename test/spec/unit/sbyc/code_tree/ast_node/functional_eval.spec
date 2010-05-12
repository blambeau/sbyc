require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#functional_eval" do
  
  context('when called on a leaf node') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce(12) }
    subject{ node.functional_eval(Kernel, {}) }
    it { should == 12 }
  end
  
  context('when called on a ?') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce([:'?', [:x]]) }
    subject{ node.functional_eval(Kernel, :x => 12) }
    it { should == 12 }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { ::SByC::parse{ (say x, "SByC") } }
    let(:master) { x = Object.new; def x.say(*args); args.join(" "); end; x}
  
    subject{ node.functional_eval(master, :x => "hello") }
    
    it { subject.should == "hello SByC" }
  end
  
end
  
