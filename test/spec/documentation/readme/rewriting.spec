require File.expand_path('../../../spec_helper', __FILE__)

describe "README # rewriting section" do
  
  let(:code) { lambda{ (concat "hello world", " ", (times "!", 3)) } }
  let(:ast)  { ::SByC::parse(code) }

  describe("What is said about the evaluation") do
    let(:rewriter) { ::SByC::Rewriter.new {|r|
      r.rule(:concat)    {|r, node, *children|   children.collect{|c| r.apply(c)}.join("") }  
      r.rule(:capitalize){|r, node, who|         r.apply(who).capitalize                   }
      r.rule(:times)     {|r, node, who, times|  r.apply(who) * r.apply(times)             }
      r.rule(:literal)   {|r, node|              node.literal                              }
    } }
    
    subject { rewriter.rewrite(ast) }
    
    it { should == "hello world !!!" }
  end

  describe("What is said about the code generation") do
    let(:rewriter) { ::SByC::Rewriter.new {|r|
      r.rule(:concat)    {|r, node, *children|   children.collect{|c| r.apply(c)}.join(" + ") }  
      r.rule(:capitalize){|r, node, who|         "#{r.apply(who)}.capitalize()"               }
      r.rule(:times)     {|r, node, who, times|  "(#{r.apply(who)} * #{r.apply(times)})"     }
      r.rule(:literal)   {|r, node|              node.literal.inspect                         }
    } }
    
    subject { rewriter.rewrite(ast) }
    
    it { should == '"hello world" + " " + ("!" * 3)' }
  end

end