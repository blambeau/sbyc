require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "Logic::Finite::AllBut#==" do
  
  let(:factory){ Logic::Finite }
  subject{ left == right }
  
  describe "when values are empty and same name" do
    let(:left){  factory::allbut(:hello, []) }
    let(:right){ factory::allbut(:hello, []) }
    it{ should == true }
  end
  
  describe "when values are empty and not same name" do
    let(:left){  factory::allbut(:hello, []) }
    let(:right){ factory::allbut(:hello2, []) }
    it{ should == false }
  end
  
  describe "when values are equal but not same name" do
    let(:left){  factory::allbut(:hello, [:x]) }
    let(:right){ factory::allbut(:hello2, [:x]) }
    it{ should == false }
  end
  
  describe "when values are equal and same name" do
    let(:left){  factory::allbut(:hello, [:x]) }
    let(:right){ factory::allbut(:hello, [:x]) }
    it{ should == true }
  end
  
  describe "when values are not equal and same name" do
    let(:left){  factory::allbut(:hello, [:x]) }
    let(:right){ factory::allbut(:hello, [:y]) }
    it{ should == false }
  end
  
  describe "when values are not equal and not same name" do
    let(:left){  factory::allbut(:hello, [:x]) }
    let(:right){ factory::allbut(:hello2, [:y]) }
    it{ should == false }
  end
  
end
