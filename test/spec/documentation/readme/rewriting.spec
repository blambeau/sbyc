require File.expand_path('../../../spec_helper', __FILE__)

describe "README # rewriting section" do
  
  let(:code) { lambda{ (concat "hello ", (get :who), (times "!", 3)) } }
  let(:ast)  { ::SByC::parse(code) }

  describe("What is said about the evaluation") do
    let(:rewriter) { ::SByC::Rewriter.new {|r|
      r.rule(:concat)      {|r, node, *children|   children.collect{|c| r.apply(c)}.join("") }  
      r.rule(:capitalize)  {|r, node, who|         r.apply(who).capitalize                   }
      r.rule(:times)       {|r, node, who, times|  r.apply(who) * r.apply(times)             }
      r.rule(:get)         {|r, node, what|        r.scope[r.apply(what)]                    }
      r.rule(:_)           {|r, node, literal|     literal                                   }
    }}
    
    subject { rewriter.rewrite(ast, :who => "SByC") }
    
    it { should == "hello SByC!!!" }
  end

  describe("What is said about the code generation") do
    let(:rewriter) { ::SByC::Rewriter.new {|r|
      r.rule(:concat)      {|r, node, *children|   children.collect{|c| r.apply(c)}.join(" + ") }  
      r.rule(:capitalize)  {|r, node, who|         "#{r.apply(who)}.capitalize()"               }
      r.rule(:times)       {|r, node, who, times|  "(#{r.apply(who)} * #{r.apply(times)})"      }
      r.rule(:get)         {|r, node, what|        "scope[#{r.apply(what)}]"                    }
      r.rule(:_)           {|r, node, literal|     literal.inspect                              }
    }}
    
    subject { rewriter.rewrite(ast) }
    
    it { should == '"hello " + scope[:who] + ("!" * 3)' }
  end

end