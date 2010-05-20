require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::AstNode#functional_eval" do
  
  context('when called on a leaf node, through coercion') do
    let(:node) { CodeTree::AstNode.coerce(12) }
    subject{ node.visit{|node, collected| [node, collected]} }
    it { should == [node, [12]] }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { CodeTree::parse{ (say x, "Hello") } }
    subject{ node.visit{|node, collected| [node.name, collected]} }
    it { subject.should == [:say, [ [ :'?', [ [ :_,  [ :x ] ] ] ], [ :_, [ "Hello" ] ] ] ] }
  end
  
  context('when called for productions') do
    let(:node) { CodeTree::parse{ (say x, "Hello") } }
    subject { 
      node.produce{|n, collected|
        case n.function
          when :'_'
            collected.first.inspect
          when :'?'
            "scope[#{collected.join(', ')}]"
          else
            "#{collected.shift}.#{n.function}(#{collected.join(', ')})"
        end
      }
    }
    it { should == 'scope[:x].say("Hello")' }
  end
  
end
