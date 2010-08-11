require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#parse_boolean_literal" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.parse_boolean_literal }
  
  describe "on current index and true" do
    let(:text){ "trueXXX" }
    specify{ 
      subject.should == CodeTree::parse{ true } 
      parser.index.should == 4
    }
  end
  
  describe "on current index and false" do
    let(:text){ "falseXXX" }
    specify{ 
      subject.should == CodeTree::parse{ false } 
      parser.index.should == 5
    }
  end
  
  ["tue", "12", ""].each{|t|
    describe "on current index and #{t}" do
      let(:text){ t }
      specify{ 
        lambda{ subject }.should raise_error(CodeTree::ParseError)
      }
    end
  }
  
end