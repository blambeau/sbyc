require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::parse" do

  let(:type_system){ TypeSystem::Ruby               }
  let(:parser)     { Logic::Parser.new(type_system) }
  subject          { parser.parse(expr)             }
  
  describe "When called a single ordered variable" do
    let(:expr){ lambda{ (x > 0) } }
    specify{ 
      subject.should be_kind_of(Logic::Ordered::Ranged)
      subject.evaluate(:x => 0).should == false
      subject.evaluate(:x => -10).should == false
      subject.evaluate(:x => 1).should == true
    }
  end
  
  describe "When called a single ordered variable" do
    let(:expr){ lambda{ (x > 0) & (x < 10) } }
    specify{ 
      subject.should be_kind_of(Logic::Ordered::Ranged) 
      subject.evaluate(:x => -1).should == false
      subject.evaluate(:x => 10).should == false
      subject.evaluate(:x => 5).should == true
    }
  end

  describe "When called on an empty solution single var expression" do
    let(:expr){ lambda{ (x < 0) & (x > 20) } }
    specify{
      subject.should be_bool_false      
      subject.evaluate(:x => -1).should == false
      subject.evaluate(:x => 10).should == false
      subject.evaluate(:x => 5).should == false
    }
  end

  describe "When called on a non empty solution with multiple var expression" do
    let(:expr){ lambda{ (x < 0) & (y > 20) } }
    specify{
      subject.should be_kind_of(Logic::And)
      subject.evaluate(:x => -1, :y => 21).should == true
      subject.evaluate(:x => 10, :y => 1).should == false
      subject.evaluate(:x => -1, :y => 21).should == true
    }
  end
  
  describe "When called on a non empty solution with multiple var expression" do
    let(:expr){ lambda{ (x >= 0) & (x <= 20) & (y > 20) } }
    it{ should be_kind_of(Logic::And) }
  end
  
  describe "When called on an empty solution with multiple var expression" do
    let(:expr){ lambda{ (x < 0) & (y > 20) & (x > 20) } }
    it{ should be_bool_false }
  end
  
end