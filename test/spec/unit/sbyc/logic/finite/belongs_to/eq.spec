require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::BelongsTo#==" do
  
  let(:factory){ Logic::Finite }
  subject{ left == right }
  
  describe "when values are empty and same name" do
    let(:left){  factory::belongs_to(:hello, []) }
    let(:right){ factory::belongs_to(:hello, []) }
    it{ should == true }
  end
  
  describe "when values are empty and not same name" do
    let(:left){  factory::belongs_to(:hello, []) }
    let(:right){ factory::belongs_to(:hello2, []) }
    it{ should == false }
  end
  
  describe "when values are equal but not same name" do
    let(:left){  factory::belongs_to(:hello, [:x]) }
    let(:right){ factory::belongs_to(:hello2, [:x]) }
    it{ should == false }
  end
  
  describe "when values are equal and same name" do
    let(:left){  factory::belongs_to(:hello, [:x]) }
    let(:right){ factory::belongs_to(:hello, [:x]) }
    it{ should == true }
  end
  
  describe "when values are not equal and same name" do
    let(:left){  factory::belongs_to(:hello, [:x]) }
    let(:right){ factory::belongs_to(:hello, [:y]) }
    it{ should == false }
  end
  
  describe "when values are not equal and not same name" do
    let(:left){  factory::belongs_to(:hello, [:x]) }
    let(:right){ factory::belongs_to(:hello2, [:y]) }
    it{ should == false }
  end
  
end
