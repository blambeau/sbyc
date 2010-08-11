require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_string_literal" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  subject{ parser.parse_string_literal }
  
  describe "with 'hello world'" do
    let(:text){ "'hello world'" }
    specify{ 
      subject.should == CodeTree::parse{ 'hello world' } 
      parser.index.should == 13
    }
  end
  
  describe "with 'hello O\\'Neil'" do
    let(:text){ %q{'hello O\'Neil'} }
    specify{ 
      subject.should == CodeTree::parse{ "hello O'Neil" } 
      parser.index.should == 15
    }
  end
  
  describe 'with "hello world"' do
    let(:text){ '"hello world"' }
    specify{ 
      subject.should == CodeTree::parse{ 'hello world' } 
      parser.index.should == 13
    }
  end
  
  describe 'with "hello world" and trailing text' do
    let(:text){ '"hello world" then other text' }
    specify{ 
      subject.should == CodeTree::parse{ 'hello world' } 
      parser.index.should == 13
      parser.current_char.should == ' '
    }
  end
  
  describe 'with "hello world" and trailing string' do
    let(:text){ '"hello world" then "other text"' }
    specify{ 
      subject.should == CodeTree::parse{ 'hello world' } 
      parser.index.should == 13
      parser.current_char.should == ' '
    }
  end

  describe 'with "hello O\\"Neil"' do
    let(:text){ %q{"hello O\"Neil"} }
    specify{ 
      subject.should == CodeTree::parse{ 'hello O"Neil' } 
      parser.index.should == 15
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