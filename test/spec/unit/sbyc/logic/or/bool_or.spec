require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::Or::bool_or" do
  
  let(:factory){ Logic::Ordered }
  
  # x < 20
  let(:x_20){ factory::lt(:x, 20) }
  
  # y > 20
  let(:y_20){ factory::gt(:y, 20) }
  
  # (x < 20) | (y > 20)
  let(:left){ Logic::Or.new([x_20,y_20]) }
  
  subject{ left.bool_or(right) }
  
  describe "with true" do
    let(:right){ Logic::TRUE }
    it{ should == right }
  end
  
  describe "with false" do
    let(:right){ Logic::FALSE }
    it{ should == left }
  end
  
  describe "with another on z" do
    let(:right){ factory::gte(:z, 20) }
    it{ should be_kind_of(Logic::Or) }
    specify{ subject.terms.size.should == 3 }
  end
  
  describe "with another on x and at least a solution" do
    # ((x >= 50) | (x < 20)) | (y > 20)
    let(:right){ factory::gte(:x, 50) }
    it{ should be_kind_of(Logic::Or) }
    specify{ 
      subject.terms.size.should == 2 
      subject.terms[0].should == x_20.bool_or(right)
      subject.terms[1].should == y_20
    }
  end
  
  describe "with another on x and a trivial solution with non-friendly order" do
    # ((x >= 20) | (x < 20)) | (y > 20)
    let(:right){ factory::gte(:x, 20) }
    it{ should be_bool_true }
  end
  
  describe "with itself" do
    let(:right){ left }
    specify{
      subject.should be_kind_of(Logic::Or)
      subject.terms.size.should == 2
      subject.terms[0].should == x_20
      subject.terms[1].should == y_20
      subject.should == left
      subject.should == right
    }
  end
  
end