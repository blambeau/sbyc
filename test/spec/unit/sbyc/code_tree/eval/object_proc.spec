require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#object_proc" do
  
  context('when called on a leaf node, through coercion') do
    let(:node) { ::SByC::expr{ 12 } }
    subject{ node.object_proc.call(nil) }
    it { should == 12 }
  end
  
  context('when called on a ?') do
    let(:node) { ::SByC::expr{ x } }
    subject{ node.object_proc.call(:x => 12) }
    it { should == 12 }
  end
  
  context('when called on an expression') do
    let(:node) { ::SByC::expr{ x + z } }
    subject{ node.object_proc.call(:x => 12, :z => 15) }
    it { should == 27 }
  end
  
  context('when called on a object-like expression') do
    let(:node) { ::SByC::expr{ x.upcase } }
    subject{ node.object_proc.call(:x => "teller") }
    it { should == "TELLER" }
  end
  
  context('when called with specific arguments') do
    let(:node) { ::SByC::expr{ x.upcase } }
    subject{ node.object_proc(:fetch).call(:x => "teller") }
    it { should == "TELLER"}
  end
  
end
  
