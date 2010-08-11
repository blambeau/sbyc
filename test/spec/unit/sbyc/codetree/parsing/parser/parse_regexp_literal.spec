require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_regexp_literal" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  subject{ parser.parse_regexp_literal }
  
  describe "with //" do
    let(:text){ "//" }
    specify{ 
      subject.should == CodeTree::parse{ // } 
      parser.index.should == 2
    }
  end
  
  describe "with /\\//" do
    let(:text){ %q{/\//} }
    specify{ 
      subject.should == CodeTree::parse{ /\// } 
      parser.index.should == 4
    }
  end
  
  describe "with /[a-z]/" do
    let(:text){ "/[a-z]/" }
    specify{ 
      subject.should == CodeTree::parse{ /[a-z]/ } 
      parser.index.should == 7
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