require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_symbol_literal" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  subject{ parser.parse_symbol_literal }
  
  describe "with :symbol" do
    let(:text){ ":symbol" }
    specify{ 
      subject.should == CodeTree::parse{ :symbol } 
      parser.index.should == 7
    }
  end
  
  describe "with :'hello-world'" do
    let(:text){ ":'hello-world'" }
    specify{ 
      subject.should == CodeTree::parse{ :'hello-world' } 
      parser.index.should == 14
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