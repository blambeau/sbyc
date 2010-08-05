require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::AllBut#bool_or" do
  
  let(:factory){ Logic::Finite }
  let(:left) { factory::allbut(:hello, [:x, :y]) }
  subject{ left.bool_or(right) }
  
  describe "AllBut | AllBut" do
    let(:right){ factory::allbut(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::AllBut) 
      subject.variable.name.should == :hello
      subject.values.should == [:y]
    }
  end
  
  describe "AllBut | BelongsTo" do
    let(:right){ factory::belongs_to(:hello, [:y, :z]) }
    specify{ 
      subject.should be_kind_of(factory::AllBut) 
      subject.variable.name.should == :hello
      subject.values.should == [:x]
    }
  end
  
end