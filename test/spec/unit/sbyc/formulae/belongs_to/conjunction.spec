require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::BelongsTo::conjunction" do
  
  let(:left) { SByC::Formulae::BelongsTo.new(:hello, [:x, :y]) }
  subject{ left.conjunction(right) }
  
  describe "BelongsTo & All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == left }
  end

  describe "BelongsTo & None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == SByC::Formulae::NONE }
  end
  
  describe "BelongsTo & BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "BelongsTo & AllBut" do
    let(:right){ SByC::Formulae::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
end