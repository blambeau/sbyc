require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#code_inject" do

  before(:all) do
    module And; end 
    module Or;  end
    module Not; end
    module Varref; end
  end
  let(:parsed) { CodeTree.parse{ ~(a & (b | c)) } }

  subject{ parsed.code_inject(:'?' => Varref, :& => And, :| => Or, :~ => Not) }

  it { should == parsed       }
  it { should be_kind_of(Not) }
  specify { 
    subject.children[0].should be_kind_of(And)
    subject.children[0].children[0].should be_kind_of(Varref)
    subject.children[0].children[1].should be_kind_of(Or)
    subject.children[0].children[1].children.all?{|c| c.should be_kind_of(Varref)}
  }

end
  
