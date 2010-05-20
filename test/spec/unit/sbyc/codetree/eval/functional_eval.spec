require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#functional_eval" do
  
  context('when called on a leaf node') do
    let(:node) { CodeTree::expr{ 12 } }
    subject{ node.functional_eval(Kernel, { }) }
    it { should == 12 }
  end
  
  context('when called on a ?') do
    let(:node) { CodeTree::expr{ x } }
    subject{ node.functional_eval(Kernel, :x => 12) }
    it { should == 12 }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { CodeTree::expr{ (say x, "You") } }
    let(:master) { x = Object.new; def x.say(*args); args.join(" "); end; x}
  
    subject{ node.functional_eval(master, :x => "hello") }
    
    it { subject.should == "hello You" }
  end
  
  context('when called on a object-like expression with specific scope method') do
    let(:node)   { CodeTree::expr{ (say x, "You") } }
    let(:master) { x = Object.new; def x.say(*args); args.join(" "); end; x}
    subject{ node.functional_eval(master, {:x => "hello"}, :fetch) }
    it { subject.should == "hello You" }
  end
  
end
  
