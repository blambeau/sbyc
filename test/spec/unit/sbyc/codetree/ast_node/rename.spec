require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#rename" do
  
  let(:expr){ CodeTree::parse{ ~(a & (b | c)) } }
  
  context "When called with a hash" do
    subject{ expr.rename!(:~ => :not, :& => :and, :| => :or, :'?' => :varref) }
    it { should == expr }
    specify { subject.to_s.should == "(not (and (varref :a), (or (varref :b), (varref :c))))" }
  end
  
  context "When called with a proc" do
    subject{ expr.rename!{|name|
      case name
        when :~
          :not
        when :&
          :and
        when :|
          :or
        when :'?'
          :varref
      end
    }}
    it { should == expr }
    specify { subject.to_s.should == "(not (and (varref :a), (or (varref :b), (varref :c))))" }
  end
  
end
