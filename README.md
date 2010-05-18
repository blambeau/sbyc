# SByC - Friendly Block Expressions

This is part of SByC, a project investigating Specialization By Constraints for Ruby.

## SYNOPSIS

This part of SByC provides a safe, reusable, extensible, mashallable, and non-intrusive (no monkey patching of Ruby core classes) implementation of block expressions. Block expressions are parsed using a generic DSL and converted to a parse tree, which may be analyzed, rewrited, compiled, and so on. The following example illustrates typical usage of SByC::expr.

    # Create a block expression
    expr = SByC::expr{ x > y }      # (> (? :x), (? :y))
    
    # Inspect its parse tree
    expr.ast                        # (> (? :x), (? :y))
    
    # Evaluate the expression
    expr.eval(:x => 5, :y => 2)     # true
    
    # Marshall it...
    Marshall::dump(expr)

## SYNTAX 

The following styles are recognized:

    # Hash-style
    SByC::parse{|t| (t[:x] > 5) & (t[:y] <= 10) }     # => (& (> (? :x), 5), (<= (? :y), 10))

    # Object-style
    SByC::parse{|t| (t.x > 5) & (t.y <= 10)     }     # => (& (> (? :x), 5), (<= (? :z), 10))

    # Context-style
    SByC::parse{ (x > 5) & (y <= 10)            }     # => (& (> (? :x), 5), (<= (? :z), 10))

    # Functional-style
    SByC::parse{ (both (gt x, 5), (lte y, 10))  }     # => (both (gt (? :x), 5), (lte (? :z), 10))

The parsing stage returns a code tree, which can be passed to a next stage (rewriting, evaluation, compilation or whatever). 

## SEMANTICS

Code trees resulting from expression parsing MUST be interpreted functionally. 

1. **Branch nodes** in the code tree correspond to a function call with arguments (see SByC::CodeTree::AstNode for details):

        (function arg0, arg1, arg2, ..., argn)

    where <code>arg0, arg1 ... argn</code> always are AstNode instances, expect for leaf nodes. Function name is accessible through the  _function_ attribute (aliased as _name_). Arguments are accessible through the _arg_ (aliased as _children_) attribute.

2. **Leaf nodes** encode literals through the special <code>'\_'</code> function. The later takes only one argument, which can be any ruby object, and is accessible through the _literal_ attribute. All and only leaf nodes have that function.

        (_ literal)

3. **Variable references** are denoted through a special function <code>'?'</code>. This operator expects one argument, i.e. the variable name, typically (but not necessarily) represented by a symbol literal.

        (? variable_name)

### Examples  

    SByC::parse{ 12 }.inspect                         # (_ 12)
    SByC::parse{ :x }.inspect                         # (_ :x)
    SByC::parse{ x  }.inspect                         # (? (_ :x))

Leaf node (and therefore, the <code>_</code> operator) only appear when invoking inspect:

    SByC::parse{ x + 12 }.inspect                     # (+ (? (_ :x)), (_ 12))
    SByC::parse{ x + 12 }.to_s                        # (+ (? :x), 12)

Parsed expressions are **functional expressions**. However, there is two ways to make their evaluation in Ruby: the object-way and the functional-way.

## OBJECT EVALUATION (_object_eval_ method, aliased as _eval_)

In object evaluation, the expression

    (function arg0, arg1, ..., argn)
    
is recursively executed as

    arg0.function(arg1, ..., argn)

For instance,

    expr = ::SByC::expr{ (x + y).to_s }               # (to_s (+ (? :x), (? :y)))
    expr.eval(:x => 3, :y => 25)                      # "28", executed as (x.+(y)).to_s()

## FUNCTIONAL EVALUATION (_functional_eval_ method, aliased as _apply_)

In functional evaluation, the expression

    (function arg0, arg1, ..., argn)
    
is recursively executed in the context of a _receiver_ object as 

    receiver.function(arg0, arg1, ..., argn)

For instance,

    expr = ::SByC::expr{ (display (concat x, y)) }    # (display (concat (? :x), (? :y)))
    expr.apply(receiver, :x => 3, :y => 25)           # 325, executed as receiver.display(receiver.concat(x, y))
  
## PRODUCTIONS and TREE REWRITING

Having a functional code tree is extremely powerful! The same code can be used in different contexts, to make different kind of productions. Consider the example below.

    ast = SByC::parse{ (concat "hello ", who, (times "!", 3)) }
    
The complete code tree is as follows:

    (concat (_ "hello "), (? (_ :who)), (times (_ "!"), (_ 3)))

The tree rewriting/production engine is inspired from XSLT and allows you to traverse the tree recursively, executing specific rules on each node. Let analyze two different productions on the foregoing example.

### An evaluation production

    # Evaluate the code above:
    rewriter = ::SByC::Rewriter.new {|r|
      r.rule(:concat)    {|r, node, *children|   r.apply(children).join("")                }  
      r.rule(:capitalize){|r, node, who|         r.apply(who).capitalize                   }
      r.rule(:times)     {|r, node, who, times|  r.apply(who) * r.apply(times)             }
      r.rule(:'?')       {|r, node, what|        r.scope[r.apply(what)]                    }
      r.rule(:'_')       {|r, node, literal|     literal                                   }
    }
    puts rewriter.rewrite(ast, :who => "SByC")        # => "hello SByC!!!"

### A compilation production

    # Generate ruby code for the code above:
    rewriter = ::SByC::Rewriter.new {|r|
      r.rule(:concat)    {|r, node, *children|   r.apply(children).join(" + ")                }  
      r.rule(:capitalize){|r, node, who|         "#{r.apply(who)}.capitalize()"               }
      r.rule(:times)     {|r, node, who, times|  "(#{r.apply(who)} * #{r.apply(times)})"      }
      r.rule(:'?')       {|r, node, what|        "scope[#{r.apply(what)}]"                    }
      r.rule(:'_')       {|r, node, literal|     literal.inspect                              }
    }
    puts rewriter.rewrite(ast)                         # => "hello " + scope[:who] + ("!" * 3)

### A rewriting production

    # Generate a ruby-version of that AST
    #   * n-adic 'concat' should be replaced by dyadic invocations '+'
    #   * 'times' should be replaced by '*'
    rewriter = ::SByC::Rewriter.new {|r|
      r.rule(:concat)  {|r, node, left, right, *residual| 
        rewrited = r.node(:+, [ r.apply(left), r.apply(right) ]) 
        if residual.empty? 
          rewrited
        else 
          r.apply(r.node(:concat, [ rewrited ] + residual))
        end
      }
      r.rule(:times)   {|r, node, *children|   r.node(:*, r.apply_all)                 }
      r.rule(r.ANY)    {|r, node, *children|   r.node(node.function, children)         }
    }
    puts rewriter.rewrite(ast)                          # => (+ (+ "hello ", (? :who)), (* "!", 3))

## LIMITATIONS (examples that DO NOT work)

**No imperative code**: SByC implicitly assumes that block's code can be interpreted functionally: no concept of variable, no sequence of code, no if/then/else, no loop. Said otherwise: your block code should always "compute a value", without having any other (state) side effect. The following will NOT work:

    SByC::parse{ if x then 0 else 1 end }           # 0

**Evaluation at parsing time**: SByC does not uses ruby2ruby or similar libraries to get an AST. It simply executes the block inside a specific DSL. Therefore, ruby expressions on literals will be evaluated at parsing time, according to operator precedence and ordering:
  
    SByC::parse{ x + 12 + 17     }                  # => (+ (+ (? :x), 12), 17)
    SByC::parse{ x + (12 + 17)   }                  # => (+ (? :x), 29)
    SByC::parse{ (x + 12) + 17   }                  # => (+ (+ (? :x), 12), 17)

**Ruby operator limitations**: for the same reason, only operators that rely on overridable methods are recognized. In particular, the following expressions will NOT work:

    SByC::parse{ x and y }                          # => (? :y)
    SByC::parse{ x && y  }                          # => (? :y)
    SByC::parse{ x or y  }                          # => (? :x)
    SByC::parse{ x || y  }                          # => (? :x)
    SByC::parse{ not(x)  }                          # => false          # Works with Ruby >= 1.9
    SByC::parse{ !x      }                          # => false          # Works with Ruby >= 1.9

## CREDITS

SByC (c) 2010 by Bernard Lambeau. SByC is distributed under the MIT licence. Please see the {file:LICENCE.md} document for details.