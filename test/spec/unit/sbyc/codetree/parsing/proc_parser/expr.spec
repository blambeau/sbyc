require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Parsing::ProcParser::Expr" do

  let(:the_expr) { CodeTree::Parsing::ProcParser::Expr.new(nil, nil, nil) }

  describe("should not have access to Kernel methods") do
    specify{ 
      x = the_expr.instance_eval{ puts "hello" } 
      lambda{ x.__to_functional_code }.should_not raise_error
      x.__to_functional_code.should be_kind_of(CodeTree::AstNode)
    }
  end
  
  describe "should not have a to_s method" do
    subject { the_expr.to_s.__to_functional_code }
    it { should be_kind_of(CodeTree::AstNode) }
  end
  
end