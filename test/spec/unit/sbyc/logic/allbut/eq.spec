require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::AllBut#==" do
  
  subject{ left == right }
  
  describe "when values are empty and same name" do
    let(:left){  Logic::AllBut.new(:hello, []) }
    let(:right){ Logic::AllBut.new(:hello, []) }
    it{ should == true }
  end
  
  describe "when values are empty and not same name" do
    let(:left){  Logic::AllBut.new(:hello, []) }
    let(:right){ Logic::AllBut.new(:hello2, []) }
    it{ should == true }
  end
  
  describe "when values are equal but not same name" do
    let(:left){  Logic::AllBut.new(:hello, [:x]) }
    let(:right){ Logic::AllBut.new(:hello2, [:x]) }
    it{ should == false }
  end
  
  describe "when values are equal and same name" do
    let(:left){  Logic::AllBut.new(:hello, [:x]) }
    let(:right){ Logic::AllBut.new(:hello, [:x]) }
    it{ should == true }
  end
  
  describe "when values are not equal and same name" do
    let(:left){  Logic::AllBut.new(:hello, [:x]) }
    let(:right){ Logic::AllBut.new(:hello, [:y]) }
    it{ should == false }
  end
  
  describe "when values are not equal and not same name" do
    let(:left){  Logic::AllBut.new(:hello, [:x]) }
    let(:right){ Logic::AllBut.new(:hello2, [:y]) }
    it{ should == false }
  end
  
end
