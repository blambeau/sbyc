require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#code_inject" do

  before(:all) do
    module CodeTreeAstNodeCodeInject 
      module And; end 
      module Or;  end
      module Not; end
      module Varref; end
    end
  end
  
  let(:parsed) { CodeTree.parse{ ~(a & (b | c)) } }
  subject{ parsed.code_inject(map_arg) }

  context "When called with a map" do
    let(:map_arg) { {:'?' => CodeTreeAstNodeCodeInject::Varref, 
                     :& => CodeTreeAstNodeCodeInject::And, 
                     :| => CodeTreeAstNodeCodeInject::Or, 
                     :~ => CodeTreeAstNodeCodeInject::Not} }

    it { should == parsed }
    it { should be_kind_of(CodeTreeAstNodeCodeInject::Not) }
    specify { 
      subject.children[0].should be_kind_of(CodeTreeAstNodeCodeInject::And)
      subject.children[0].children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Varref)
      subject.children[0].children[1].should be_kind_of(CodeTreeAstNodeCodeInject::Or)
      subject.children[0].children[1].children.all?{|c| c.should be_kind_of(CodeTreeAstNodeCodeInject::Varref)}
    }
  end

  context "When called with a module" do
    let(:map_arg){ CodeTreeAstNodeCodeInject }

    it { pending("This depends on Name2X implem"){ should == parsed } }
    #it { should be_kind_of(CodeTreeAstNodeCodeInject::Not) }
    # specify { 
    #   subject.children[0].should be_kind_of(CodeTreeAstNodeCodeInject::And)
    #   subject.children[0].children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Varref)
    #   subject.children[0].children[1].should be_kind_of(CodeTreeAstNodeCodeInject::Or)
    #   subject.children[0].children[1].children.all?{|c| c.should be_kind_of(CodeTreeAstNodeCodeInject::Varref)}
    # }
  end

end
  
