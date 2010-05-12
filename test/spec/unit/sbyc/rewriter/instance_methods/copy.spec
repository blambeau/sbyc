require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter#copy" do
  
  let(:engine) { SByC::Rewriter.new }
  
  context "when called on a leaf node" do 
    let(:node) { ::SByC::parse{ 12 } }
    
    subject{ engine.copy(node).inspect }
    
    it { should == ::SByC::parse{ 12 }.inspect }
  end
  
end

