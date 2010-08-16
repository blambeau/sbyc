require File.expand_path('../../fixtures', __FILE__)
describe "R::Operator::Set" do
  
  SByCFixturesOperatorSetFoo = R::Operator::Set.factor(R::Boolean)
  SByCFixturesOperatorSetBar = R::Operator::Set.factor(R::String)
  SByCFixturesOperatorSetFoo.define{ 
    operator{|op| 
      op.aliases   = [:hello] 
      op.signature = SByC::R::Operator::Signature.s(R::String)
    }
    def hello(who); "Hello #{who}" end
  }
  SByCFixturesOperatorSetBar.define{
    operator{|op| 
      op.aliases   = [:hello2] 
      op.signature = SByC::R::Operator::Signature.s(R::String)
    }
    def hello2(who); "Hello too #{who}" end
  }
  
  it "should support installing methods" do
    (op = SByCFixturesOperatorSetFoo.find_operator_by_signature(:hello, [R::String])).should_not be_nil
    op.call(["elodie"]).should == "Hello elodie"
    (op2 = SByCFixturesOperatorSetBar.find_operator_by_signature(:hello2, [R::String])).should_not be_nil
    op2.call(["elodie"]).should == "Hello too elodie"
  end
  
  it 'should avoid collisions' do
    SByCFixturesOperatorSetFoo.find_operator_by_signature(:hello2, [R::String]).should be_nil
    SByCFixturesOperatorSetBar.find_operator_by_signature(:hello, [R::String]).should be_nil
  end
  
end