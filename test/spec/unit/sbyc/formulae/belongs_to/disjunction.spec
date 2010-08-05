require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::BelongsTo::disjunction" do
  
  let(:left) { SByC::Formulae::BelongsTo.new(:hello, [:x, :y]) }
  subject{ left.disjunction(right) }
  
  describe "BelongsTo | All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == SByC::Formulae::ALL }
  end

  describe "BelongsTo | None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == left }
  end

  describe "BelongsTo | BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y, :z]
    }
  end
  
  describe "BelongsTo | AllBut" do
    let(:right){ SByC::Formulae::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:z]
    }
  end
  
end