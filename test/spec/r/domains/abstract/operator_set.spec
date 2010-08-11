require File.expand_path('../../../fixtures', __FILE__)
describe "R::AbstractDomain::OperatorSet" do
  
  let(:ops) { R::AbstractDomain::OperatorSet.factor(nil) }
  let(:ops2){ R::AbstractDomain::OperatorSet.factor(nil) }
  
  before do
    ops.define{ 
      operator{|op| 
        op.aliases   = [:hello] 
        op.signature = [R::String]
      }
      def hello(who); "Hello #{who}" end
    }
    ops2.define{
      operator{|op| 
        op.aliases   = [:hello2] 
        op.signature = [R::String]
      }
      def hello2(who); "Hello too #{who}" end
    }
  end
  
  it "should support installing methods" do
    (op = ops.find_operator(:hello, [R::String])).should_not be_nil
    op.call("elodie").should == "Hello elodie"
    (op2 = ops2.find_operator(:hello2, [R::String])).should_not be_nil
    op2.call("elodie").should == "Hello too elodie"
  end
  
  it 'should avoid collisions' do
    ops.find_operator(:hello2, [R::String]).should be_nil
    ops2.find_operator(:hello, [R::String]).should be_nil
  end
  
  it "should be installed as class methods" do
    ops.instance.should respond_to(:hello)
  end
  
end