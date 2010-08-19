require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#parse_domain_generation_literal" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.parse_domain_generation_literal }
  
  describe "when called on Kernel" do
    let(:text){ "Kernel" }
    it{ should == CodeTree::parse{ Kernel } }
  end
  
  describe "when called on SByC::CodeTree" do
    let(:text){ "SByC::CodeTree" }
    it{ should == CodeTree::parse{ SByC::CodeTree } }
  end
  
  describe "when called on Array<String>" do
    let(:text){ "Array<String>" }
    specify{
      subject.to_s.should == "(ArrayDomain String)"
    }
  end
  
  describe "when called on Array<String>" do
    let(:text){ "Array<String, Integer>" }
    specify{
      subject.to_s.should == "(ArrayDomain String, Integer)"
    }
  end
  
  describe "when called on Array<SByC<Integer>>" do
    let(:text){ "Array<SByC<Integer>>" }
    specify{
      subject.to_s.should == "(ArrayDomain (SByCDomain Integer))"
    }
  end
  
  describe "when called on Array<SByC<Integer>, Array<Symbol>>" do
    let(:text){ "Array<SByC<Integer>, Array<Symbol>>" }
    specify{
      subject.to_s.should == "(ArrayDomain (SByCDomain Integer), (ArrayDomain Symbol))"
    }
  end
  
end