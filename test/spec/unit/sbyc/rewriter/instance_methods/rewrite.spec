require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter" do

  describe "when called without scope" do 
    subject{
      ::SByC::Rewriter.new {|r|
        r.rule(:concat)    {|r, *args| args.collect{|c| r.apply(c)}.join }
        r.rule(:literal)   {|r, node| node.literal                       }
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
      ::SByC::Rewriter.new {|r|
        r.rule(:concat)    {|r, *args| args.collect{|c| r.apply(c)}.join }
        r.rule(:get)       {|r, name|  r.scope[r.apply(name)]            }
        r.rule(:literal)   {|r, node| node.literal                       }
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
  
end