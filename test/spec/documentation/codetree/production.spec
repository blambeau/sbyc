require File.expand_path('../../../spec_helper', __FILE__)

describe "Gh-Pages documentation: codetree/production.redcloth" do

  describe "What is said about the visit method" do
    subject {
      CodeTree::parse{ z * (x + y).to_s }.visit do |node, collected|
        if node.function == :'?'
          node.literal
        else
          collected.flatten
        end
      end
    }
    it { should == [:z, :x, :y] }
  end
  
  describe "What is said about the visit method (second example)" do
    subject {
      values = {:x => 3, :y => 6, :z => 2}
      CodeTree::parse{ z * (x + y) }.visit do |node, collected|
        case node.function
          when :'?'
            values[node.literal]
          when :'+'
            collected[0] + collected[1]
          when :'*'
            collected[0] * collected[1]
        end
      end
    }
    it { should == 18 }
  end
  
  describe "What is said about the engine (first example)" do
    let(:producer) {
      ::CodeTree::producer{|p|
        
        # This rule matches leaf nodes (literals)
        p.rule(:'_') do |engine, node|
          "On: #{node.literal.inspect}"
        end
        
        # This rule matches everything else
        p.rule("*") do |engine, node| 
          "Before: #{node.inspect}"
          engine.apply(node.children)
          "After: #{node.inspect}"
          nil
        end
        
      }
    }
    let(:expr) { CodeTree::parse{ (concat "hello ", who) } }
    subject { producer.apply(expr) }
    it { should be_nil }
  end
  
end