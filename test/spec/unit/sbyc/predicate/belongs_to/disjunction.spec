require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::BelongsTo::disjunction" do
  
  let(:left) { SByC::Predicate::BelongsTo.new(:hello, [:x, :y]) }
  subject{ left.disjunction(right) }
  
  describe "BelongsTo | All" do
    let(:right){ SByC::Predicate::ALL }
    it{ should == SByC::Predicate::ALL }
  end

  describe "BelongsTo | None" do
    let(:right){ SByC::Predicate::NONE }
    it{ should == left }
  end

  describe "BelongsTo | BelongsTo" do
    let(:right){ SByC::Predicate::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y, :z]
    }
  end
  
  describe "BelongsTo | AllBut" do
    let(:right){ SByC::Predicate::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:z]
    }
  end
  
end