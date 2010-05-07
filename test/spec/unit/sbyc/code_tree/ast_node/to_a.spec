require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#to_a" do
  
  context("with a literal") do
    subject { ::SByC::CodeTree::AstNode.coerce(12).to_a }
    it { should == 12 }
  end
  
  context("without children") do
    subject { ::SByC::CodeTree::AstNode.coerce([ :plus, [ ] ]).to_a }
    it { should == [ :plus, [ ] ] }
  end
  
  context("without literal children") do
    let(:expected) { [ :plus, [ 12, 15 ] ] }
    subject { ::SByC::CodeTree::AstNode.coerce(expected).to_a }
    it { should == expected }
  end
  
  context("without complex children") do
    let(:expected) { [ :plus, [ [ :minus, [ 15, 16 ] ], 17 ] ] }
    subject { ::SByC::CodeTree::AstNode.coerce(expected).to_a }
    it { should == expected }
  end
  
end 