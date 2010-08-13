require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#parse_domain_generation" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.parse_domain_generation }
  
  describe "with SByC<Integer>" do
    let(:text){ "SByC<Integer>" }
    specify{ 
      subject.to_s.should == "(generate-domain SByC, Integer)"
    }
  end
  
  describe "with SByC<Integer, String>" do
    let(:text){ "SByC<Integer, String>" }
    specify{ 
      subject.to_s.should == "(generate-domain SByC, Integer, String)"
    }
  end
  
  describe "with SByC::CodeTree::AstNode<SByC::CodeTree>" do
    let(:text){ "SByC::CodeTree::AstNode<SByC::CodeTree>" }
    specify{ 
      subject.to_s.should == "(generate-domain SByC::CodeTree::AstNode, SByC::CodeTree)"
    }
  end
  
end