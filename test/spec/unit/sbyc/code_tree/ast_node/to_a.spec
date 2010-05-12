require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#to_a" do
  
  context("with a __literal__") do
    subject { ::SByC::CodeTree::AstNode.coerce(12).to_a }
    it { should == [:__literal__, [ 12 ]] }
  end
  
  context("without children") do
    subject { ::SByC::CodeTree::AstNode.coerce([ :plus, [ ] ]).to_a }
    it { should == [ :plus, [ ] ] }
  end
  
  context("with __literal__ children") do
    let(:expected) { [ :plus, [ [:__literal__, [12]], [:__literal__, [15]] ] ] }
    subject { ::SByC::parse{ (plus 12, 15) }.to_a }
    it { should == expected }
  end
  
  context("with variables") do
    let(:expected) { [ :plus, [ [:__scope_get__, [ [:__literal__, [ :x ] ] ] ] ] ] }
    subject { ::SByC::parse{ (plus x) }.to_a }
    it { should == expected }
  end
  
end 