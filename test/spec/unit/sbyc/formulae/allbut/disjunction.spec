require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::AllBut::disjunction" do
  
  let(:left) { SByC::Formulae::AllBut.new(:hello, [:x, :y]) }
  subject{ left.disjunction(right) }
  
  describe "AllBut | All" do
    let(:right){ SByC::Formulae::ALL }
    it{ should == SByC::Formulae::ALL }
  end

  describe "AllBut | None" do
    let(:right){ SByC::Formulae::NONE }
    it{ should == left }
  end

  describe "Allbut | Allbut" do
    let(:right){ SByC::Formulae::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "AllBut | BelongsTo" do
    let(:right){ SByC::Formulae::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Formulae::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
end