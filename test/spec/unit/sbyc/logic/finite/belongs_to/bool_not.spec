require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::BelongsTo#bool_not" do
  
  let(:factory){ Logic::Finite }
  subject{ left.bool_not }
  
  describe "~ BelongsTo" do
    let(:left) { factory::belongs_to(:hello, [:x, :y]) }
    specify{ 
      subject.should be_kind_of(factory::AllBut) 
      subject.variable.name.should == :hello
      subject.values.should == [:x, :y]
    }
  end
  
end