require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::BelongsTo::conjunction" do
  
  let(:left) { SByC::Predicate::BelongsTo.new(:hello, [:x, :y]) }
  subject{ left.conjunction(right) }
  
  describe "BelongsTo & All" do
    let(:right){ SByC::Predicate::ALL }
    it{ should == left }
  end

  describe "BelongsTo & None" do
    let(:right){ SByC::Predicate::NONE }
    it{ should == SByC::Predicate::NONE }
  end
  
  describe "BelongsTo & BelongsTo" do
    let(:right){ SByC::Predicate::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "BelongsTo & AllBut" do
    let(:right){ SByC::Predicate::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
end