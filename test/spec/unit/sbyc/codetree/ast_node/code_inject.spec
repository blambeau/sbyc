require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#code_inject!" do
  
  module CodeTreeAstNodeCodeInject 
    module Hello;       end 
    module Capitalize;  end
    module Varref;      end
  end

  let(:parsed) { CodeTree.parse{ (hello (capitalize name)) }.rename!(:'?' => :varref) }

  context "When called with a map" do
    let(:map_arg) { {:varref     => CodeTreeAstNodeCodeInject::Varref, 
                     :hello      => CodeTreeAstNodeCodeInject::Hello, 
                     :capitalize => CodeTreeAstNodeCodeInject::Capitalize} }
    subject{ parsed.code_inject!(map_arg) }
    it { should == parsed }
    it { should be_kind_of(CodeTreeAstNodeCodeInject::Hello) }
    specify { 
      subject.children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Capitalize)
      subject.children[0].children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Varref)
    }
  end

  context "When called with a proc" do
    subject{ parsed.code_inject!{|name|
      case name
        when :varref
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
  
  context "When called with a module" do
    let(:map_arg){ CodeTreeAstNodeCodeInject }
    subject{ parsed.code_inject!(map_arg) }
    it { should == parsed }
    it { should be_kind_of(CodeTreeAstNodeCodeInject::Hello) }
    specify { 
      subject.children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Capitalize)
      subject.children[0].children[0].should be_kind_of(CodeTreeAstNodeCodeInject::Varref)
    }
  end

end
  
