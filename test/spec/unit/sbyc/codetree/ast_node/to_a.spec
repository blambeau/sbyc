require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#to_a" do
  
  context("with a _") do
    subject { CodeTree::AstNode.coerce(12).to_a }
    it { should == [:_, [ 12 ]] }
  end
  
  context("without children") do
    subject { CodeTree::AstNode.coerce([ :plus, [ ] ]).to_a }
    it { should == [ :plus, [ ] ] }
  end
  
  context("with _ children") do
    let(:expected) { [ :plus, [ [:_, [12]], [:_, [15]] ] ] }
    subject { CodeTree::parse{ (plus 12, 15) }.to_a }
    it { should == expected }
  end
  
  context("with variables") do
    let(:expected) { [ :plus, [ [:'?', [ [:_, [ :x ] ] ] ] ] ] }
    subject { CodeTree::parse{ (plus x) }.to_a }
    it { should == expected }
  end
  
end 