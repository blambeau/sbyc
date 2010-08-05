require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::And::bool_and" do
  
  let(:factory){ Logic::Ordered }
  
  # x < 20
  let(:x_20){ factory::lt(:x, 20) }
  
  # y > 20
  let(:y_20){ factory::gt(:y, 20) }
  
  # (x < 20) & (y > 20)
  let(:left){ Logic::And.new([x_20,y_20]) }
  
  subject{ left.bool_and(right) }
  
  describe "with true" do
    let(:right){ Logic::TRUE }
    it{ should == left }
  end
  
  describe "with false" do
    let(:right){ Logic::FALSE }
    it{ should == right }
  end
  
  describe "with another on z" do
    let(:right){ factory::gte(:z, 20) }
    it{ should be_kind_of(Logic::And) }
    specify{ subject.terms.size.should == 3 }
  end
  
  describe "with another on x and at least a solution" do
    # ((x > 0) & (x < 20)) & (y > 20)
    let(:right){ factory::gte(:x, 0) }
    it{ should be_kind_of(Logic::And) }
    specify{ 
      subject.terms.size.should == 2 
      subject.terms[0].should == x_20.bool_and(right)
      subject.terms[1].should == y_20
    }
  end
  
  describe "with another on x and no solution with non-friendly order" do
    # ((x >= 100) & (x < 20)) & (y > 20)
    let(:right){ factory::gte(:x, 100) }
    it{ should be_bool_false }
  end
  
end