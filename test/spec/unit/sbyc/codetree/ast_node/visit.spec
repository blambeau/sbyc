require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::AstNode#functional_eval" do
  
  context('when called on a leaf node, through coercion') do
    let(:node) { ::SByC::CodeTree::AstNode.coerce(12) }
    subject{ node.visit{|node, collected| [node, collected]} }
    it { should == [node, [12]] }
  end
  
  context('when called on a object-like expression') do
    let(:node)   { ::SByC::parse{ (say x, "SByC") } }
    subject{ node.visit{|node, collected| [node.name, collected]} }
    it { subject.should == [:say, [ [ :'?', [ [ :_,  [ :x ] ] ] ], [ :_, [ "SByC" ] ] ] ] }
  end
  
  context('when called for productions') do
    let(:node) { ::SByC::parse{ (say x, "SByC") } }
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
    it { should == 'scope[:x].say("SByC")' }
  end
  
end
