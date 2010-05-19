require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::ProcParser::Expr" do

  let(:the_expr) { ::SByC::CodeTree::ProcParser::Expr.new }

  describe("should not have access to Kernel methods") do
    specify{ 
      x = the_expr.instance_eval{ puts "hello" } 
      lambda{ x.__to_functional_code }.should_not raise_error
      x.__to_functional_code.should be_kind_of(::SByC::CodeTree::AstNode)
    }
  end
  
  describe "should not have a to_s method" do
    subject { the_expr.to_s.__to_functional_code }
    it { should be_kind_of(::SByC::CodeTree::AstNode) }
  end
  
end