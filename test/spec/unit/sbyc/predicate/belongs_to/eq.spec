require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::BelongsTo#==" do
  
  subject{ left == right }
  
  describe "when values are empty and same name" do
    let(:left){  Predicate::BelongsTo.new(:hello, []) }
    let(:right){ Predicate::BelongsTo.new(:hello, []) }
    it{ should == true }
  end
  
  describe "when values are empty and not same name" do
    let(:left){  Predicate::BelongsTo.new(:hello, []) }
    let(:right){ Predicate::BelongsTo.new(:hello2, []) }
    it{ should == true }
  end
  
  describe "when values are equal but not same name" do
    let(:left){  Predicate::BelongsTo.new(:hello, [:x]) }
    let(:right){ Predicate::BelongsTo.new(:hello2, [:x]) }
    it{ should == false }
  end
  
  describe "when values are equal and same name" do
    let(:left){  Predicate::BelongsTo.new(:hello, [:x]) }
    let(:right){ Predicate::BelongsTo.new(:hello, [:x]) }
    it{ should == true }
  end
  
  describe "when values are not equal and same name" do
    let(:left){  Predicate::BelongsTo.new(:hello, [:x]) }
    let(:right){ Predicate::BelongsTo.new(:hello, [:y]) }
    it{ should == false }
  end
  
  describe "when values are not equal and not same name" do
    let(:left){  Predicate::BelongsTo.new(:hello, [:x]) }
    let(:right){ Predicate::BelongsTo.new(:hello2, [:y]) }
    it{ should == false }
  end
  
end
