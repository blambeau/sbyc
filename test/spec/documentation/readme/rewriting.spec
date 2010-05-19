require File.expand_path('../../../spec_helper', __FILE__)

describe "README # rewriting section" do
  
  let(:code) { lambda{ (concat "hello ", who, (times "!", 3)) } }
  let(:ast)  { CodeTree::parse(code) }
  
  describe('What is said about the ast') do
    subject{ ast.inspect }
    it { should == '(concat (_ "hello "), (? (_ :who)), (times (_ "!"), (_ 3)))' }
  end

  describe("What is said about the evaluation") do
    let(:rewriter) { CodeTree::rewriter {|r|
      r.rule(:concat)      {|r, node, *children|   r.apply(children).join("")                }  
      r.rule(:capitalize)  {|r, node, who|         r.apply(who).capitalize                   }
      r.rule(:times)       {|r, node, who, times|  r.apply(who) * r.apply(times)             }
      r.rule(:'?')         {|r, node, what|        r.scope[r.apply(what)]                    }
      r.rule(:'_')         {|r, node, literal|     literal                                   }
    }}
    
    subject { rewriter.rewrite(ast, :who => "You") }
    
    it { should == "hello You!!!" }
  end

  describe("What is said about the code generation") do
    let(:rewriter) { CodeTree::rewriter {|r|
      r.rule(:concat)      {|r, node, *children|   r.apply(children).join(" + ")                }  
      r.rule(:capitalize)  {|r, node, who|         "#{r.apply(who)}.capitalize()"               }
      r.rule(:times)       {|r, node, who, times|  "(#{r.apply(who)} * #{r.apply(times)})"      }
      r.rule(:'?')         {|r, node, what|        "scope[#{r.apply(what)}]"                    }
      r.rule(:'_')         {|r, node, literal|     literal.inspect                              }
    }}
    
    subject { rewriter.rewrite(ast) }
    
    it { should == '"hello " + scope[:who] + ("!" * 3)' }
  end
  
  describe("What is said about the code tree rewriting") do
    let(:rewriter) { CodeTree::rewriter {|r|
      r.rule(:concat)  {|r, node, left, right, *residual| 
        rewrited = r.node(:+, r.apply(left), r.apply(right))
        if residual.empty? 
          rewrited
        else 
          r.apply(r.node(:concat, [ rewrited ] + residual))
        end
      }
      r.rule(:times)   {|r, node, *children|   r.node(:*, r.apply(children))                  }
      r.rule(r.ANY)    {|r, node, *children|   r.node(node.function, children)                }
    }}
    
    subject { rewriter.rewrite(ast).to_s }
    
    it { should == '(+ (+ "hello ", who), (* "!", 3))' }
  end

end