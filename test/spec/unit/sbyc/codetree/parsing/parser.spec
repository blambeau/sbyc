require File.expand_path('../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#each" do
  
  let(:file){ File.expand_path('../fixtures/expressions.r', __FILE__) }
  let(:expressions){ File.read(file) }
  let(:parser){ CodeTree::Parsing::Parser.new(expressions) }
  
  it "should yield expressions" do
    parser.each{|expr| expr.should be_kind_of(CodeTree::AstNode) }
  end
  
end