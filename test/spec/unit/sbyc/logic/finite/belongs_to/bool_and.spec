require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::BelongsTo::bool_and" do
  
  let(:factory){ Logic::Finite }
  let(:left) { factory::belongs_to(:hello, [:x, :y]) }
  subject{ left.bool_and(right) }
  
  describe "BelongsTo & BelongsTo" do
    let(:right){ factory::belongs_to(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::BelongsTo) 
      subject.variable.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "BelongsTo & AllBut" do
    let(:right){ factory::allbut(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::BelongsTo) 
      subject.variable.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
  describe "BelongsTo & AllBut on disjoint" do
    let(:right){ factory::allbut(:hello, [:a, :z]) }
    specify{ 
      subject.should be_kind_of(factory::BelongsTo) 
      subject.variable.name.should == :hello
      subject.values.should == [:x, :y]
    }
  end
  
  describe "BelongsTo & AllBut on same" do
    let(:right){ factory::allbut(:hello, [:y, :x]) }
    specify{ 
      subject.should == factory::none(:hello)
      subject.variable.name.should == :hello
    }
  end
  
end