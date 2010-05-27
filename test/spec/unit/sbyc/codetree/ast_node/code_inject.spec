require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#code_inject" do
  
  module CodeTreeAstNodeCodeInject 
    module Hello;       end 
    module Capitalize;  end
    module Varref;      end
  end

  let(:parsed) { CodeTree.parse{ (hello (capitalize name)) } }

  subject{ parsed.code_inject(map_arg) }

  context "When called with a map" do
    let(:map_arg) { {:'?'        => CodeTreeAstNodeCodeInject::Varref, 
                     :hello      => CodeTreeAstNodeCodeInject::Hello, 
                     :capitalize => CodeTreeAstNodeCodeInject::Capitalize} }

    it { should == parsed }
    it { should be_kind_of(CodeTreeAstNodeCodeInject::Hello) }
    specify { 
      subject.children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Capitalize)
      subject.children[0].children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Varref)
    }
  end

  context "When called with a proc" do
    let(:map_arg) { lambda {|name|
      case name
        when :'?'
          CodeTreeAstNodeCodeInject::Varref
        when :hello
          CodeTreeAstNodeCodeInject::Hello
        when :capitalize
          CodeTreeAstNodeCodeInject::Capitalize
      end
    } }

    it { should == parsed }
    it { should be_kind_of(CodeTreeAstNodeCodeInject::Hello) }
    specify { 
      subject.children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Capitalize)
      subject.children[0].children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Varref)
    }
  end

  # context "When called with a module" do
  #   let(:map_arg){ CodeTreeAstNodeCodeInject }
  # 
  #   it { should == parsed }
  #   it { should be_kind_of(CodeTreeAstNodeCodeInject::Not) }
  #   specify { 
  #     subject.children[0].should be_kind_of(CodeTreeAstNodeCodeInject::And)
  #     subject.children[0].children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Varref)
  #     subject.children[0].children[1].should be_kind_of(CodeTreeAstNodeCodeInject::Or)
  #     subject.children[0].children[1].children.all?{|c| c.should be_kind_of(CodeTreeAstNodeCodeInject::Varref)}
  #   }
  # end

end
  
