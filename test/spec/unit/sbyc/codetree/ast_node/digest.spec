require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#digest" do

  module CodeTreeAstNodeDigestTest
    class Dyadic 
      attr_reader :left, :right
      def initialize(left, right)
        @left, @right = left, right
      end
    end
    class And < Dyadic; end 
    class Or < Dyadic; end 
    class Not 
      attr_reader :term
      def initialize(term)
        @term = term
      end
    end
    class Varref
      attr_reader :varname
      def initialize(varname)
        @varname = varname
      end
    end
  end
  
  context "when called with a hash" do
    let(:parsed) { CodeTree.parse{ ~(a & (b | c)) } }
    subject{ parsed.digest(:'?' => CodeTreeAstNodeDigestTest::Varref, 
                           :&   => CodeTreeAstNodeDigestTest::And, 
                           :|   => CodeTreeAstNodeDigestTest::Or, 
                           :~   => CodeTreeAstNodeDigestTest::Not) }
    it { should be_kind_of(CodeTreeAstNodeDigestTest::Not) }
    specify { 
      subject.term.should be_kind_of(CodeTreeAstNodeDigestTest::And)
      subject.term.left.should be_kind_of(CodeTreeAstNodeDigestTest::Varref)
      subject.term.left.varname.should == :a
      subject.term.right.should be_kind_of(CodeTreeAstNodeDigestTest::Or)
      subject.term.right.left.should be_kind_of(CodeTreeAstNodeDigestTest::Varref)
    }
  end

  context "when called with a proc" do
    let(:parsed) { CodeTree.parse{ ~(a & (b | c)) } }
    subject{ parsed.digest{|name|
      case name
        when :'?'
          CodeTreeAstNodeDigestTest::Varref
        when :&
          CodeTreeAstNodeDigestTest::And
        when :|
          CodeTreeAstNodeDigestTest::Or
        when :~
          CodeTreeAstNodeDigestTest::Not
      end
    } }
    it { should be_kind_of(CodeTreeAstNodeDigestTest::Not) }
    specify { 
      subject.term.should be_kind_of(CodeTreeAstNodeDigestTest::And)
      subject.term.left.should be_kind_of(CodeTreeAstNodeDigestTest::Varref)
      subject.term.left.varname.should == :a
      subject.term.right.should be_kind_of(CodeTreeAstNodeDigestTest::Or)
      subject.term.right.left.should be_kind_of(CodeTreeAstNodeDigestTest::Varref)
    }
  end

  context "when called with a module" do
    let(:parsed) { CodeTree.parse{ ~(a & (b | c)) } }
    let(:renamed) { parsed.rename!(:& => :and, :| => :or, :~ => :not, :'?' => :varref) }
    subject{ renamed.digest(CodeTreeAstNodeDigestTest) }  
    it { should be_kind_of(CodeTreeAstNodeDigestTest::Not) }
    specify { 
      subject.term.should be_kind_of(CodeTreeAstNodeDigestTest::And)
      subject.term.left.should be_kind_of(CodeTreeAstNodeDigestTest::Varref)
      subject.term.left.varname.should == :a
      subject.term.right.should be_kind_of(CodeTreeAstNodeDigestTest::Or)
      subject.term.right.left.should be_kind_of(CodeTreeAstNodeDigestTest::Varref)
    }
  end
  
end
  
