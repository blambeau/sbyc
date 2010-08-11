require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#eat_spaces" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.eat_spaces }
  
  describe "when no spaces are present" do
    let(:text){ "" }
    specify{ 
      subject.should == ''
      parser.index.should == 0
    }
  end
  
  describe "when single spaces are present" do
    let(:text){ "  " }
    specify{ 
      subject.should == '  '
      parser.index.should == 2
    }
  end
  
  describe "when a comment is present" do
    let(:text){ "  #hello\n  x" }
    specify{ 
      subject.strip.should == '#hello'
      parser.current_char.should == 'x'
    }
  end
  
  describe "when single multiline spaces are present" do
    let(:text){ "  \t\n  hello" }
    specify{ 
      subject.strip.should be_empty
      parser.current_char.should == 'h'
    }
  end
  
end