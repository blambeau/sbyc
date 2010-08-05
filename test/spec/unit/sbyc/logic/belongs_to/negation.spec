require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::BelongsTo::negation" do
  
  subject{ left.negation }
  
  describe "BelongsTo.negation" do
    let(:left) { SByC::Logic::BelongsTo.new(:hello, [:x, :y]) }
    it{ 
      should be_kind_of(SByC::Logic::AllBut) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y]
    }
  end
  
end