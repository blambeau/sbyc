require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::AllBut::disjunction" do
  
  let(:left) { SByC::Predicate::AllBut.new(:hello, [:x, :y]) }
  subject{ left.disjunction(right) }
  
  describe "AllBut | All" do
    let(:right){ SByC::Predicate::ALL }
    it{ should == SByC::Predicate::ALL }
  end

  describe "AllBut | None" do
    let(:right){ SByC::Predicate::NONE }
    it{ should == left }
  end

  describe "Allbut | Allbut" do
    let(:right){ SByC::Predicate::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "AllBut | BelongsTo" do
    let(:right){ SByC::Predicate::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Predicate::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
end