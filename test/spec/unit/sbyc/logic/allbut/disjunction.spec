require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::AllBut::disjunction" do
  
  let(:left) { SByC::Logic::AllBut.new(:hello, [:x, :y]) }
  subject{ left.disjunction(right) }
  
  describe "AllBut | All" do
    let(:right){ SByC::Logic::ALL }
    it{ should == SByC::Logic::ALL }
  end

  describe "AllBut | None" do
    let(:right){ SByC::Logic::NONE }
    it{ should == left }
  end

  describe "Allbut | Allbut" do
    let(:right){ SByC::Logic::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Logic::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "AllBut | BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Logic::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
end