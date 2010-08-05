require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::BelongsTo::bool_or" do
  
  let(:factory){ Logic::Finite }
  let(:left) { factory::belongs_to(:hello, [:x, :y]) }
  subject{ left.bool_or(right) }
  
  describe "BelongsTo | BelongsTo" do
    let(:right){ factory::belongs_to(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::BelongsTo) 
      subject.variable.name.should == :hello
      subject.values.should == [:x, :y, :z]
    }
  end
  
  describe "BelongsTo | AllBut" do
    let(:right){ factory::allbut(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::AllBut) 
      subject.variable.name.should == :hello
      subject.values.should == [:z]
    }
  end
  
end