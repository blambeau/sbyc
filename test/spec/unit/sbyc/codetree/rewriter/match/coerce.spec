require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "SByC::CodeTree::Rewriting::Rewriter::Match.coerce?" do
  
  let(:branch) { ::SByC::parse{ (branch :hello) } }
  let(:leaf)   { ::SByC::parse{ :hello }          }
  
  context("when called with a symbol") do
    subject{ ::SByC::CodeTree::Rewriting::Rewriter::Match.coerce(:branch, nil) }
    
    it { should === branch }
    it { should_not === leaf }
  end
  
  context("when called with a proc") do
    let(:predicate) { lambda{|node| node.leaf? }}
    subject{ ::SByC::CodeTree::Rewriting::Rewriter::Match.coerce(predicate, nil) }
    
    it { should_not === branch }
    it { should === leaf }
  end
  
  context("when called with '.'") do
    subject{ ::SByC::CodeTree::Rewriting::Rewriter::Match.coerce(".", nil) }
    
    it { should === 12 }
    it { should === branch }
    it { should === leaf }
  end
  
  context("when called with '*'") do
    subject{ ::SByC::CodeTree::Rewriting::Rewriter::Match.coerce("*", nil) }
    
    it { should_not === 12 }
    it { should === branch }
    it { should_not === leaf }
  end
  
  context("when called with '@*'") do
    subject{ ::SByC::CodeTree::Rewriting::Rewriter::Match.coerce("@*", nil) }
    
    it { should_not === 12 }
    it { should_not === branch }
    it { should === leaf }
  end
  
end
  
