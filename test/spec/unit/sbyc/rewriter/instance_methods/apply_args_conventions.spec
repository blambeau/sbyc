require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter#apply_args_conventions" do

  let(:rewriter) { ::SByC::Rewriter.new }

  context "when called with a literal" do
    let(:node)     { 12 }
    subject { rewriter.apply_args_conventions(node) }
    it { should == node }
  end

  context "when called with a single ASTNode instance" do
    let(:node)     { ::SByC::parse{ 12 }  }
    subject { rewriter.apply_args_conventions(node) }
    it { should == node }
  end

  context "when called with multiple ASTNode instances" do
    let(:child1)   { ::SByC::parse{ "hello" }                          }
    let(:child2)   { ::SByC::parse{ "world" }                          }
    subject        { rewriter.apply_args_conventions(child1, child2)   }
    it { should == [child1, child2] }
  end

  context "when called with an array of ASTNode instances" do
    let(:child1)   { ::SByC::parse{ "hello" }                          }
    let(:child2)   { ::SByC::parse{ "world" }                          }
    subject        { rewriter.apply_args_conventions([child1, child2]) }
    it { should == [child1, child2] }
  end

  context "when called with a function and a single ASTNode child" do
    let(:function) { :testfunc                      }
    let(:child)    { ::SByC::parse{ 12 }            }
    let(:expected) { ::SByC::parse{ (testfunc 12) } }
    subject{ rewriter.apply_args_conventions(function, child) }
    it { should == expected }
  end 
  
  context "when called with a function and two ASTNode children" do
    let(:function) { :say                                              }
    let(:child1)   { ::SByC::parse{ "hello" }                          }
    let(:child2)   { ::SByC::parse{ "world" }                          }
    let(:expected) { ::SByC::parse{ (say "hello", "world") }           }
    subject{ rewriter.apply_args_conventions(function, child1, child2) }
    it { should == expected }
  end 
  
end