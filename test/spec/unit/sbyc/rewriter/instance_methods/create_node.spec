require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter#copy" do
  
  let(:engine) { SByC::Rewriter.new }
  
  context "when called with a literal" do 
    subject{ engine.create_node(:test, [ 12 ]).inspect }
    
    it { should == ::SByC::parse{ (test 12) }.inspect }
  end
  
  context "when called with copy in mind" do
    let(:node) { ::SByC::parse{ 12 } } 

    subject{ engine.create_node(node.function, node.children).inspect }
    
    it { should == ::SByC::parse{ 12 }.inspect }
  end
  
end

