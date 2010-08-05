require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::BelongsTo::conjunction" do
  
  let(:left) { SByC::Logic::BelongsTo.new(:hello, [:x, :y]) }
  subject{ left.conjunction(right) }
  
  describe "BelongsTo & All" do
    let(:right){ SByC::Logic::ALL }
    it{ should == left }
  end

  describe "BelongsTo & None" do
    let(:right){ SByC::Logic::NONE }
    it{ should == SByC::Logic::NONE }
  end
  
  describe "BelongsTo & BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Logic::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "BelongsTo & AllBut" do
    let(:right){ SByC::Logic::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Logic::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
end