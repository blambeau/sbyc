require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_operator_call" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  subject{ parser.parse_operator_call }
  
  describe "on a typical operator call" do
    let(:text){ "(gte 10, 12)" }
    specify{
      subject.should == CodeTree::parse{ (gte 10, 12) }
    }
  end
  
  describe "on a typical operator call with unbound variable" do
    let(:text){ "(gte x, 12)" }
    specify{
      subject.should == CodeTree::parse{ (gte x, 12) }
    }
  end
  
  describe "on a typical operator call without comma" do
    let(:text){ "(gte x 12)" }
    specify{
      subject.should == CodeTree::parse{ (gte x, 12) }
    }
  end
  
end