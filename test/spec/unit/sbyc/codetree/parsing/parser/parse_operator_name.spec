require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_operator_name" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  subject{ parser.parse_operator_name }
  
  describe "with name" do
    let(:text){ "name" }
    specify{ 
      subject.should == :name
      parser.index.should == 4
    }
  end
  
  describe "with name on index 1" do
    let(:text){ "(name" }
    specify{ 
      parser.index = 1
      subject.should == :name
      parser.index.should == 5
    }
  end
  
  describe "with special chars" do
    let(:text){ "this-is-valid_also" }
    specify{ 
      subject.should == :'this-is-valid_also'
      parser.index.should == text.length
    }
  end
  
  describe "with special symbols" do
    let(:text){ ">=?" }
    specify{ 
      subject.should == :'>=?'
      parser.index.should == text.length
    }
  end
  
  ["", ":hello"].each{|t|
    describe "on current index and #{t}" do
      let(:text){ t }
      specify{ 
        lambda{ subject }.should raise_error(CodeTree::ParseError)
      }
    end
  }
  
end