require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::And.new" do
  
  subject{ Logic::And.new(*terms) }
  let(:arbitrar){ Logic::Between.new(:age, Interval.point(18)) }
  
  describe "when called with empty args" do
    let(:terms){ [] }
    it{ should == Logic::TRUE }
  end
  
  describe "when called with only all in args" do
    let(:terms){ [ Logic::TRUE ] }
    it{ should == Logic::TRUE }
  end
  
  describe "when called with only none in args" do
    let(:terms){ [ Logic::FALSE ] }
    it{ should == Logic::FALSE }
  end
  
  describe "when called with only one arg" do
    let(:terms){ [ arbitrar ] }
    it{ should == arbitrar }
  end
  
  describe "when called with at least one FALSE" do
    let(:terms){ [ arbitrar, Logic::FALSE ] }
    it{ should == Logic::FALSE }
  end
  
  describe "when called with at least one TRUE" do
    let(:terms){ [ arbitrar, Logic::TRUE ] }
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
    let(:expected){ Logic::FALSE }
    it{ should == expected }
  end
  
  describe "when called with predicates on different attr" do
    let(:terms){ [ Logic::gt(:x, 18), Logic::lt(:x, 50), Logic::lt(:y, 18) ] }
    it{ should be_kind_of(Logic::And) }
    specify{ subject.terms.size.should == 2 }
  end
  
end