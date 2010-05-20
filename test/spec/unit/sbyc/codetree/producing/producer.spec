require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::Producing::Producer" do
  
  let(:expr){ CodeTree::parse{ ~(a & b) } }
  
  context 'when called with default rules' do
    let(:producer) { 
      CodeTree::producer{|p|
        p.rule(:~){|r, n| "not(#{r.apply(n[0])})"                  }
        p.rule(:&){|r, n| "(#{r.apply(n.children).join(' and ')})" }
        p.rule(:|){|r, n| "(#{r.apply(n.children).join(' or ')})"  }
      }
    }
    subject{ producer.apply(expr) }
    it{ should == "not((a and b))" }
  end
  
  context 'when called without default rules' do
    let(:producer) { 
      CodeTree::producer(false){|p|
        p.rule("*"){|r,n| [n.function] + r.apply(n.children)}
      }
    }
    subject{ producer.apply(expr) }
    specify{ producer.rules.size.should == 1 }
    it{ should == [:~, [:&, [:'?', [:_, :a]], [:'?', [:_, :b]]]] }
  end
  
end

