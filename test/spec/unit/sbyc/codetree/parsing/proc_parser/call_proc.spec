require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::ProcParser#call_proc" do
  
  subject{ CodeTree::Parsing::ProcParser::call_proc(proc).__to_functional_code }
  
  describe "When the proc has one argument and something is done" do
    let(:proc){ lambda{|t| t.name} }
    specify{ 
      subject.should be_kind_of(SByC::CodeTree::AstNode) 
      subject.function.should == :'?'
      subject.literal.should == :name
    }
  end

  describe "When the proc has no argument" do
    let(:proc){ lambda{ name } }
    specify{ 
      subject.should be_kind_of(SByC::CodeTree::AstNode) 
      subject.function.should == :'?'
      subject.literal.should == :name
    }
  end

end