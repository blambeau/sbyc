require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#==" do
  
  context "when applied on equal literal nodes" do
    let(:n1) { ::SByC::parse{ 12 } }
    let(:n2) { ::SByC::parse{ 12 } }
    subject { (n1 == n2) and (n2 == n1) }
    it { should be_true }
  end

  context "when applied on itself with a literal node" do
    let(:n1) { ::SByC::parse{ 12 } }
    let(:n2) { n1 }
    subject { (n1 == n2) and (n2 == n1) }
    it { should be_true }
  end
  
  context "when applied on non equal literal nodes" do
    let(:n1) { ::SByC::parse{ 12 } }
    let(:n2) { ::SByC::parse{ 13 } }
    subject { (n1 == n2) or (n2 == n1) }
    it { should be_false }
  end

  context "when applied on itself with a tree" do
    let(:n1) { ::SByC::parse{ (concat (say "hello"), "world") } }
    let(:n2) { n1 }
    subject { (n1 == n2) and (n2 == n1) }
    it { should be_true }
  end
  
  context "when applied on equal trees" do
    let(:n1) { ::SByC::parse{ (concat (say "hello"), "world") } }
    let(:n2) { ::SByC::parse{ (concat (say "hello"), "world") } }
    subject { (n1 == n2) and (n2 == n1) }
    it { should be_true }
  end
  
  context "when applied on non equal trees (with one being a literal)" do
    let(:n1) { ::SByC::parse{ (concat (say "hello"), "world") } }
    let(:n2) { 12 }
    subject { (n1 == n2) or (n2 == n1) }
    it { should be_false }
  end
  
  context "when applied on non equal trees (none being a literal)" do
    let(:n1) { ::SByC::parse{ (concat (say "hello"), "world") } }
    let(:n2) { ::SByC::parse{ (concat "hello", "world") } }
    subject { (n1 == n2) or (n2 == n1) }
    it { should be_false }
  end
  
  context "when applied on non equal trees (with a literal difference)" do
    let(:n1) { ::SByC::parse{ (concat (say "hello"), "world") } }
    let(:n2) { ::SByC::parse{ (concat (say "hello"), "world2") } }
    subject { (n1 == n2) or (n2 == n1) }
    it { should be_false }
  end
  
  context "when applied on non equal trees (with a function difference)" do
    let(:n1) { ::SByC::parse{ (concat (say "hello"), "world") } }
    let(:n2) { ::SByC::parse{ (concat (say2 "hello"), "world") } }
    subject { (n1 == n2) or (n2 == n1) }
    it { should be_false }
  end
  
  context "when applied on non equal trees (order difference)" do
    let(:n1) { ::SByC::parse{ (concat (say "hello"), "world") } }
    let(:n2) { ::SByC::parse{ (concat "world", (say "hello")) } }
    subject { (n1 == n2) or (n2 == n1) }
    it { should be_false }
  end
  
end