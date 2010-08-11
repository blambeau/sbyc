require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_variable_literal" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  subject{ parser.parse_variable_literal }
  
  describe "with name" do
    let(:text){ "name" }
    specify{ 
      subject.should == CodeTree::parse{ name } 
    }
  end
  
  ["true", 'false', "12", "(a"].each{|t|
    describe "on current index and #{t}" do
      let(:text){ t }
      specify{ 
        lambda{ subject }.should raise_error(CodeTree::ParseError)
      }
    end
  }
  
end