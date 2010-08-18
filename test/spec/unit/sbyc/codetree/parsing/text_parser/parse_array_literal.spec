require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#parse_array_literal" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.parse_array_literal }
  
  describe "with an empty array" do
    let(:text){ "[]" }
    specify{ 
      subject.should == CodeTree::AstNode.new(:Array, [])
    }
  end
  
  describe "with a non-empty singleton array" do
    let(:text){ "[ 12 ]" }
    specify{ 
      subject.should == CodeTree::parse{ (Array 12) }
    }
  end
  
  describe "with a non-empty array" do
    let(:text){ "[ 12, 'blambeau' ]" }
    specify{ 
      subject.should == CodeTree::parse{ (Array 12, 'blambeau') }
    }
  end

  describe "with special variables" do
    let(:text){ "[$0 $1]" }
    specify{ 
      subject.to_s.should == "(Array $0, $1)"
    }
  end
  
end