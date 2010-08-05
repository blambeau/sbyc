require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::AllBut::conjunction" do
  
  let(:left) { SByC::Formulae::AllBut.new(:hello, [:x, :y]) }
  subject{ left.conjunction(right) }
  
  describe "AllBut & All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == left }
  end

  describe "AllBut & None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == SByC::Formulae::NONE }
  end

  describe "AllBut & AllBut" do
    let(:right){ SByC::Formulae::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y, :z]
    }
  end
  
  describe "AllBut & BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:z]
    }
  end
  
end