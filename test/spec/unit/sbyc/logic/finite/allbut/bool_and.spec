require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::AllBut::bool_and" do
  
  let(:factory){ Logic::Finite }
  let(:left) { factory::allbut(:hello, [:x, :y]) }
  subject{ left.bool_and(right) }
  
  describe "AllBut & AllBut" do
    let(:right){ factory::allbut(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::AllBut)
      subject.variable.name.should == :hello
      subject.values.should == [:x, :y, :z]
    }
  end
  
  describe "AllBut & BelongsTo" do
    let(:right){ factory::belongs_to(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::BelongsTo) 
      subject.variable.name.should == :hello
      subject.values.should == [:z]
    }
  end
  
  describe "AllBut & BelongsTo on disjoint" do
    let(:right){ factory::belongs_to(:hello, [:a, :z]) }
    specify{ 
      subject.should be_kind_of(factory::BelongsTo) 
      subject.variable.name.should == :hello
      subject.values.should == [:a, :z]
    }
  end
  
  describe "AllBut & BelongsTo on same" do
    let(:right){ factory::belongs_to(:hello, [:y, :x]) }
    specify{ 
      subject.should == factory::none(:hello)
      subject.variable.name.should == :hello
    }
  end
  
end