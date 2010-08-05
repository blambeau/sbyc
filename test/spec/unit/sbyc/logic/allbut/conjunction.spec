require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::AllBut::conjunction" do
  
  let(:left) { SByC::Logic::AllBut.new(:hello, [:x, :y]) }
  subject{ left.conjunction(right) }
  
  describe "AllBut & All" do
    let(:right){ SByC::Logic::TRUE }
    it{ should == left }
  end

  describe "AllBut & None" do
    let(:right){ SByC::Logic::FALSE }
    it{ should == SByC::Logic::FALSE }
  end

  describe "AllBut & AllBut" do
    let(:right){ SByC::Logic::AllBut.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Logic::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y, :z]
    }
  end
  
  describe "AllBut & BelongsTo" do
    let(:right){ SByC::Logic::BelongsTo.new(:hello, [:y, :z]) }
    it{ 
      should be_kind_of(SByC::Logic::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:z]
    }
  end
  
end