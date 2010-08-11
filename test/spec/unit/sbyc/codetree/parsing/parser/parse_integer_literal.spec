require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_integer_literal" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  subject{ parser.parse_integer_literal }
  
  describe "on current index and 0" do
    let(:text){ "0" }
    it{ should == CodeTree::parse{ 0 } }
  end
  
  describe "on current index and 132" do
    let(:text){ "132" }
    it{ should == CodeTree::parse{ 132 } }
  end

  describe "when not found" do
    [ "hello 0", "0hello", "hello0" ].each{|t|
      let(:text){ t }
      specify{ lambda{ subject }.should raise_error(CodeTree::ParseError) }
    }
  end
  
end