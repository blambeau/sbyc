require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::AllBut#bool_not" do
  
  let(:factory){ Logic::Finite }
  subject{ left.bool_not }
  
  describe "AllBut.negation" do
    let(:left) { factory::allbut(:hello, [:x, :y]) }
    specify{ 
      subject.should be_kind_of(factory::BelongsTo) 
      subject.variable.name.should == :hello
      subject.values.should == [:x, :y]
    }
  end
  
end