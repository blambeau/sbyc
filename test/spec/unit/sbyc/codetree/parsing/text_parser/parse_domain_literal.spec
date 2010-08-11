require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#parse_domain_literal" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.parse_domain_literal }
  
  describe "with Kernel" do
    let(:text){ "Kernel" }
    specify{ 
      subject.should == CodeTree::parse{ Kernel } 
      parser.index.should == 6
    }
  end
  
  describe "with SByC::CodeTree" do
    let(:text){ "SByC::CodeTree" }
    specify{ 
      subject.should == CodeTree::parse{ SByC::CodeTree } 
      parser.index.should == 14
    }
  end
  
  describe "with SByC::CodeTree::Parsing" do
    let(:text){ "SByC::CodeTree::Parsing" }
    specify{ 
      subject.should == CodeTree::parse{ SByC::CodeTree::Parsing } 
      parser.index.should == 23
    }
  end
  
end