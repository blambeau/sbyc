require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::TextParser#parse_float_literal" do
  
  let(:parser){ CodeTree::Parsing::TextParser.new(text) }
  subject{ parser.parse_float_literal }
  
  describe "on current index and 0.0" do
    let(:text){ "0.0" }
    it{ should == CodeTree::parse{ 0.0 } }
  end
  
  describe "on current index and -1.0" do
    let(:text){ "-1.0" }
    it{ should == CodeTree::parse{ -1.0 } }
  end
  
  describe "on current index and -1.0hello" do
    let(:text){ "-1.0hello" }
    specify{ 
      subject.should == CodeTree::parse{ -1.0 } 
      parser.index.should == 4
    }
  end
  
  [ "hello 0", "hello0", "0", "1"].each{|t|
    describe "when not found" do
        let(:text){ t }
        specify{ lambda{ subject }.should raise_error(CodeTree::ParseError) }
    end
  }
  
end