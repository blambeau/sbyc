require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::And.new" do
  
  subject{ Logic::And.new(*terms) }
  let(:arbitrar){ Logic::Between.new(:age, Interval.point(18)) }
  
  describe "when called with empty args" do
    let(:terms){ [] }
    it{ should == Logic::ALL }
  end
  
  describe "when called with only all in args" do
    let(:terms){ [ Logic::ALL ] }
    it{ should == Logic::ALL }
  end
  
  describe "when called with only none in args" do
    let(:terms){ [ Logic::NONE ] }
    it{ should == Logic::NONE }
  end
  
  describe "when called with only one arg" do
    let(:terms){ [ arbitrar ] }
    it{ should == arbitrar }
  end
  
  describe "when called with at least one NONE" do
    let(:terms){ [ arbitrar, Logic::NONE ] }
    it{ should == Logic::NONE }
  end
  
  describe "when called with at least one ALL" do
    let(:terms){ [ arbitrar, Logic::ALL ] }
    it{ should == arbitrar }
  end
  
  describe "when called with twice the same predicate" do
    let(:terms){ [arbitrar, arbitrar] }
    it{ should == arbitrar }
  end
  
  describe "when called with predicates on same attr" do
    let(:terms){ [ Logic::gt(:x, 18), Logic::gt(:x, 20) ] }
    let(:expected){ Logic::gt(:x, 20) }
    it{ should == expected }
  end
  
  describe "when called with predicates on same attr that would lead to empty" do
    let(:terms){ [ Logic::gt(:x, 20), Logic::lt(:x, 10) ] }
    let(:expected){ Logic::NONE }
    it{ should == expected }
  end
  
  describe "when called with predicates on different attr" do
    let(:terms){ [ Logic::gt(:x, 18), Logic::lt(:x, 50), Logic::lt(:y, 18) ] }
    it{ should be_kind_of(Logic::And) }
    specify{ subject.terms.size.should == 2 }
  end
  
end