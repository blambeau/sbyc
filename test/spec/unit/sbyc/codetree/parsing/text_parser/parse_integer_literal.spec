require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#parse_integer_literal" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.parse_integer_literal }
  
  describe "on current index and 0" do
    let(:text){ "0" }
    specify{ 
      subject.should == CodeTree::parse{ 0 } 
      parser.index.should == 1
    }
  end
  
  describe "on current index and -0" do
    let(:text){ "-0" }
    specify{ 
      subject.should == CodeTree::parse{ 0 }
      parser.index.should == 2
    }
  end
  
  describe "on current index and +0" do
    let(:text){ "-0" }
    it{ should == CodeTree::parse{ 0 } }
  end
  
  describe "on current index and 10" do
    let(:text){ "10" }
    it{ should == CodeTree::parse{ 10 } }
  end

  describe "on current index and 132" do
    let(:text){ "132" }
    it{ should == CodeTree::parse{ 132 } }
  end

  describe "on current index and -132" do
    let(:text){ "-132" }
    it{ should == CodeTree::parse{ -132 } }
  end

  describe "on current index and 0hello" do
    let(:text){ "0hello" }
    specify{ 
      subject.should == CodeTree::parse{ 0 }
      parser.index.should == 1
    }
  end

  [ "hello 0", "hello0" ].each{|t|
    describe "when applied on #{t}" do
      let(:text){ t }
      specify{ 
        lambda{ subject }.should raise_error(CodeTree::ParseError) 
      }
    end
  }
  
end