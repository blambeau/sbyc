require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#to_a" do
  
  context("with a _") do
    subject { ::SByC::CodeTree::AstNode.coerce(12).to_a }
    it { should == [:_, [ 12 ]] }
  end
  
  context("without children") do
    subject { ::SByC::CodeTree::AstNode.coerce([ :plus, [ ] ]).to_a }
    it { should == [ :plus, [ ] ] }
  end
  
  context("with _ children") do
    let(:expected) { [ :plus, [ [:_, [12]], [:_, [15]] ] ] }
    subject { ::SByC::parse{ (plus 12, 15) }.to_a }
    it { should == expected }
  end
  
  context("with variables") do
    let(:expected) { [ :plus, [ [:'?', [ [:_, [ :x ] ] ] ] ] ] }
    subject { ::SByC::parse{ (plus x) }.to_a }
    it { should == expected }
  end
  
end 