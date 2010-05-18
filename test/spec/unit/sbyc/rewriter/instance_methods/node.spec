require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter#copy" do
  
  let(:engine) { SByC::Rewriter.new }
  
  context "when called with a literal" do 
    subject{ engine.node(:test, [ 12 ]) }
    it { should == ::SByC::parse{ (test 12) } }
  end
  
  context "when called with copy in mind" do
    let(:node) { ::SByC::parse{ 12 } } 
    subject{ engine.node(node.function, node.children) }
    it { should == ::SByC::parse{ 12 } }
  end
  
end

