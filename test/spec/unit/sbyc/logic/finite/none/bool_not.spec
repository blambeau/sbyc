require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::None#bool_not" do
  
  let(:factory){ Logic::Finite }
  subject{ left.bool_not }
  
  describe "~ Any" do
    let(:left) { factory::none(:hello) }
    specify{ 
      subject.should be_kind_of(factory::Any) 
      subject.variable.name.should == :hello
    }
  end
  
end