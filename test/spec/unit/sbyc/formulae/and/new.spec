require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Formulae::And.new" do
  
  subject{ Formulae::And.new(*terms) }
  let(:arbitrar){ Formulae::Between.new(:age, Interval.point(18)) }
  
  describe "when called with empty args" do
    let(:terms){ [] }
    it{ should == Formulae::ALL }
  end
  
  describe "when called with only all in args" do
    let(:terms){ [ Formulae::ALL ] }
    it{ should == Formulae::ALL }
  end
  
  describe "when called with only none in args" do
    let(:terms){ [ Formulae::NONE ] }
    it{ should == Formulae::NONE }
  end
  
  describe "when called with only one arg" do
    let(:terms){ [ arbitrar ] }
    it{ should == arbitrar }
  end
  
  describe "when called with at least one NONE" do
    let(:terms){ [ arbitrar, Formulae::NONE ] }
    it{ should == Formulae::NONE }
  end
  
  describe "when called with at least one ALL" do
    let(:terms){ [ arbitrar, Formulae::ALL ] }
    it{ should == arbitrar }
  end
  
  describe "when called with twice the same predicate" do
    let(:terms){ [arbitrar, arbitrar] }
    it{ should == arbitrar }
  end
  
  describe "when called with predicates on same attr" do
    let(:terms){ [ Formulae::gt(:x, 18), Formulae::gt(:x, 20) ] }
    let(:expected){ Formulae::gt(:x, 20) }
    it{ should == expected }
  end
  
  describe "when called with predicates on same attr that would lead to empty" do
    let(:terms){ [ Formulae::gt(:x, 20), Formulae::lt(:x, 10) ] }
    let(:expected){ Formulae::NONE }
    it{ should == expected }
  end
  
  describe "when called with predicates on different attr" do
    let(:terms){ [ Formulae::gt(:x, 18), Formulae::lt(:x, 50), Formulae::lt(:y, 18) ] }
    it{ should be_kind_of(Formulae::And) }
    specify{ subject.terms.size.should == 2 }
  end
  
end