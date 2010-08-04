require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::AllBut::conjunction" do
  
  let(:left) { SByC::Predicate::AllBut.new(:hello, [:x, :y]) }
  subject{ left.conjunction(right) }
  
  describe "AllBut & All" do
    let(:right){ SByC::Predicate::ALL }
    it{ should == left }
  end

  describe "AllBut & None" do
    let(:right){ SByC::Predicate::NONE }
    it{ should == SByC::Predicate::NONE }
  end

  describe "AllBut & AllBut" do
    let(:right){ SByC::Predicate::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y, :z]
    }
  end
  
  describe "AllBut & BelongsTo" do
    let(:right){ SByC::Predicate::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:z]
    }
  end
  
end