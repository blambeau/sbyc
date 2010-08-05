require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::Ordered factory /" do
  
  let(:factory){ Logic::Ordered }
  
  describe "any" do
    specify{ 
      term = factory.any(:var)
      term.should be_kind_of(factory::Any) 
      term.variable.name.should == :var
    }
  end
  
  describe "none" do
    specify{ 
      term = factory.none(:var)
      term.should be_kind_of(factory::None) 
      term.variable.name.should == :var
    }
  end
  
  describe "ranged with empty interval" do
    specify{ 
      term = factory.ranged(:var, Interval.empty)
      term.should be_kind_of(factory::None) 
      term.variable.name.should == :var
    }
  end
  
  describe "ranged with all interval" do
    specify{ 
      term = factory.ranged(:var, Interval.all)
      term.should be_kind_of(factory::Any) 
      term.variable.name.should == :var
    }
  end
  
end