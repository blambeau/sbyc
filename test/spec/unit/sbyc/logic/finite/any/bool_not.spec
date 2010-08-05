require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::Any#bool_not" do
  
  let(:factory){ Logic::Finite }
  subject{ left.bool_not }
  
  describe "~ Any" do
    let(:left) { factory::any(:hello) }
    specify{ 
      subject.should be_kind_of(factory::None) 
      subject.variable.name.should == :hello
    }
  end
  
end