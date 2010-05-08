require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::FunctionalParser#parse" do
  
  context("with a simple method call") do
    let(:code) { proc { (plus 12, 15) }}
    subject { ::SByC::CodeTree::FunctionalParser::parse(code).to_a }
    it { should == [ :plus, [ 12, 15 ] ] }
  end
  
  context("with something more complex") do
    let(:code) { proc { (plus (minus 12, 16), 15) }}
    subject { ::SByC::CodeTree::FunctionalParser::parse(code).to_a }
    it { should == [ :plus, [ [ :minus, [ 12, 16 ] ], 15 ] ] }
  end
  
  context("with a simple method call given by a string") do
    let(:code) { "(plus 12, 15)" }
    subject { ::SByC::CodeTree::FunctionalParser::parse(code).to_a }
    it { should == [ :plus, [ 12, 15 ] ] }
  end
  
end