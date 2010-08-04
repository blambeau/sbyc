require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::AllBut::negation" do
  
  subject{ left.negation }
  
  describe "AllBut.negation" do
    let(:left) { SByC::Predicate::AllBut.new(:hello, [:x, :y]) }
    it{ 
      should be_kind_of(SByC::Predicate::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y]
    }
  end
  
end