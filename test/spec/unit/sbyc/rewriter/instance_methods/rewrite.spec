require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter" do

  describe "when called without scope" do 
    subject{
      ::SByC::Rewriter.new {|r|
        r.rule(:concat)        {|r, node, *args| args.collect{|c| r.apply(c)}.join }
        r.rule(:_)   {|r, node| node.literal                             }
      }
    }
  
    it { should be_kind_of(::SByC::Rewriter) }
  
    context("when applied on an ast string") do
      specify { subject.rewrite("(concat 1, 2, 3)").should == "123" }
    end
  
    context("when applied with a proc argument") do
      let(:code){ lambda{ (concat 1, 2, 3) } }
      specify { subject.rewrite(code).should == "123" }
    end
  
    context("when applied with a block") do
      specify { subject.rewrite{ (concat 1, 2, 3) }.should == "123" }
    end
    
  end

  describe "when called with a scope object" do 
    subject{
      ::SByC::Rewriter.new     {|r|
        r.rule(:concat)        {|r, node, *args| args.collect{|c| r.apply(c)}.join }
        r.rule(:get)           {|r, node, name|  r.scope[r.apply(name)]            }
        r.rule(:_)   {|r, node| node.literal                             }
      }
    }
  
    it { should be_kind_of(::SByC::Rewriter) }
  
    context("when applied on an ast string") do
      specify { subject.rewrite("(get :hello)", :hello => "world").should == "world" }
    end
      
    context("when applied with a proc argument") do
      let(:code){ lambda{ (get :hello) } }
      specify { subject.rewrite(code, :hello => "world").should == "world" }
    end
      
    context("when applied with a block") do
      specify { subject.rewrite(:hello => "world"){ (get :hello) }.should == "world" }
    end
  end
  
  describe "when only an ANY match is installed" do
    subject{ ::SByC::Rewriter.new{|r| 
      r.rule(::SByC::Rewriter::Match::ANY){|r, node, arg| node.leaf? ? arg : r.apply(arg) } 
    }}
    
    it "should return inner-most argument" do
      subject.rewrite{ (call (other (one :hello))) }.should == :hello
    end
  end
  
  describe "when only an LEAF/BRANCH are used" do
    subject{ ::SByC::Rewriter.new{|r| 
      r.rule(::SByC::Rewriter::Match::BRANCH){|r, node, child| r.apply(child)}
      r.rule(::SByC::Rewriter::Match::LEAF){|r, node| node.literal}
    }}
    
    it "should return inner-most argument" do
      subject.rewrite{ (call (other (one :hello))) }.should == :hello
    end
  end
  
end