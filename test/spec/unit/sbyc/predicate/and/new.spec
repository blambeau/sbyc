require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Predicate::And.new" do
  
  subject{ Predicate::And.new(*terms) }
  let(:arbitrar){ Predicate::Between.new(:age, Interval.point(18)) }
  
  describe "when called with empty args" do
    let(:terms){ [] }
    it{ should == Predicate::ALL }
  end
  
  describe "when called with only all in args" do
    let(:terms){ [ Predicate::ALL ] }
    it{ should == Predicate::ALL }
  end
  
  describe "when called with only none in args" do
    let(:terms){ [ Predicate::NONE ] }
    it{ should == Predicate::NONE }
  end
  
  describe "when called with only one arg" do
    let(:terms){ [ arbitrar ] }
    it{ should == arbitrar }
  end
  
  describe "when called with at least one NONE" do
    let(:terms){ [ arbitrar, Predicate::NONE ] }
    it{ should == Predicate::NONE }
  end
  
  describe "when called with at least one ALL" do
    let(:terms){ [ arbitrar, Predicate::ALL ] }
    it{ should == arbitrar }
  end
  
  describe "when called with twice the same predicate" do
    let(:terms){ [arbitrar, arbitrar] }
    it{ should == arbitrar }
  end
  
  describe "when called with predicates on same attr" do
    let(:terms){ [ Predicate::gt(:x, 18), Predicate::gt(:x, 20) ] }
    let(:expected){ Predicate::gt(:x, 20) }
    it{ should == expected }
  end
  
  describe "when called with predicates on same attr that would lead to empty" do
    let(:terms){ [ Predicate::gt(:x, 20), Predicate::lt(:x, 10) ] }
    let(:expected){ Predicate::NONE }
    it{ should == expected }
  end
  
  describe "when called with predicates on different attr" do
    let(:terms){ [ Predicate::gt(:x, 18), Predicate::lt(:x, 50), Predicate::lt(:y, 18) ] }
    it{ should be_kind_of(Predicate::And) }
    specify{ subject.terms.size.should == 2 }
  end
  
end