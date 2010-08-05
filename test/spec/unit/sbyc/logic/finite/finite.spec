require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::Finite factory /" do
  
  let(:factory){ Logic::Finite }
  
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
  
  describe "allbut with empty values" do
    specify{ 
      term = factory.allbut(:var, [])
      term.should be_kind_of(factory::Any) 
      term.variable.name.should == :var
    }
  end
  
  describe "allbut with values" do
    specify{ 
      term = factory.allbut(:var, [:x])
      term.should be_kind_of(factory::AllBut) 
      term.variable.name.should == :var
      term.values.should == [:x]
    }
  end
  
  describe "belongs_to with empty values" do
    specify{ 
      term = factory.belongs_to(:var, [])
      term.should be_kind_of(factory::None) 
      term.variable.name.should == :var
    }
  end
  
  describe "belongs_to with values" do
    specify{ 
      term = factory.belongs_to(:var, [:x])
      term.should be_kind_of(factory::BelongsTo) 
      term.variable.name.should == :var
      term.values.should == [:x]
    }
  end
  
end