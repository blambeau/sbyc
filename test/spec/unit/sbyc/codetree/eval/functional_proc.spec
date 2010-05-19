require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#functional_proc" do
  
  let(:receiver) {
    o = Object.new
    def o.upcase(x); x.upcase; end
    o
  }
  
  context('when called on a leaf node') do
    let(:node) { CodeTree::expr{ 12 } }
    subject{ node.functional_proc.call(nil, nil) }
    it { should == 12 }
  end
  
  context('when called on a ?') do
    let(:node) { CodeTree::expr{ x } }
    subject{ node.functional_proc.call(receiver, :x => "hello") }
    it { should == "hello" }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { CodeTree::expr{ (upcase x) } }
    subject{ node.functional_proc.call(receiver, :x => "hello") }
    it { should == 'HELLO' }
  end
  
  context('when called with specific arguments') do
    let(:node)   { CodeTree::expr{ (upcase x) } }
    subject{ node.functional_proc(:fetch).call(receiver, :x => "hello") }
    it { should == 'HELLO' }
  end
  
end
  
