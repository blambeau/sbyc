require File.expand_path('../../../spec_helper', __FILE__)

describe "::SByC#parse" do
  
  context "when passed a string" do
    subject { ::SByC::parse("x > z") }
    it { should be_kind_of(::SByC::CodeTree::AstNode) }
  end
  
  context "when passed a block" do
    subject { ::SByC::parse{x > z} }
    it { should be_kind_of(::SByC::CodeTree::AstNode) }
  end
  
  context "when passed an AstNode" do
    subject { ::SByC::parse(::SByC::parse{x > z}) }
    it { should be_kind_of(::SByC::CodeTree::AstNode) }
  end
  
end

