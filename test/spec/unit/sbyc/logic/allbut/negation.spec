require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::AllBut::negation" do
  
  subject{ left.negation }
  
  describe "AllBut.negation" do
    let(:left) { SByC::Logic::AllBut.new(:hello, [:x, :y]) }
    it{ 
      should be_kind_of(SByC::Logic::BelongsTo) 
    }
    specify{ 
      subject.name.should == :hello
      subject.values.should == [:x, :y]
    }
  end
  
end