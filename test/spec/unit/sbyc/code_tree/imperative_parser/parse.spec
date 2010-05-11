require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::ImperativeParser#parse" do
  
  subject { ::SByC::CodeTree::ImperativeParser::parse(code) }

  context "when called with an argument" do 
    let(:functional) { proc { (plus (get :a), 12) }                          }
    let(:expected)   { ::SByC::CodeTree::FunctionalParser::parse(functional) }

    context("with a simple literal") do
      let(:code)        { proc {|t| 12 } }
      specify { subject.inspect.should == ::SByC::parse{ 12 }.inspect }
    end
  
    context("with a simple operator call") do
      let(:code)        { proc {|t| t[:a] + 12       } }
      specify { subject.inspect.should == expected.inspect }
    end
  
    context("with a simple operator call and dot heuristic") do
      let(:code)        { proc {|t| t.a + 12 } }
      specify { subject.inspect.should == expected.inspect }
    end
  
    context("with a simple method call") do
      let(:code)        { proc {|t| t[:a].plus(12)   } }
      specify { subject.inspect.should == expected.inspect }
    end
  
    context("with a simple method call and dot heuristic") do
      let(:code)        { proc {|t| t.a.plus(12)   } }
      specify { subject.inspect.should == expected.inspect }
    end
  
    context("with left literal at left") do
      let(:code)        { proc {|t| 12 + t[:a]       } }
      specify { subject.inspect.should == expected.inspect }
    end

    context("with left literal at left and dot heuristic") do
      let(:code)        { proc {|t| 12 + t.a       } }
      specify { subject.inspect.should == expected.inspect }
    end
  end
  
  context "when called without argument" do
    let(:functional) { proc { (plus (get :a), 12) }                          }
    let(:expected)   { ::SByC::CodeTree::FunctionalParser::parse(functional) }

    context("with a simple literal") do
      let(:code)        { proc { 12 } }
      specify { subject.inspect.should == ::SByC::parse{ 12 }.inspect }
    end
  
    context("with a simple operator call") do
      let(:code)        { proc { a + 12 } }
      specify { subject.inspect.should == expected.inspect }
    end
  
    context("with a simple method call") do
      let(:code)        { proc { a.plus(12)   } }
      specify { subject.inspect.should == expected.inspect }
    end
  
    context("with left literal at left") do
      let(:code)        { proc { 12 + a } }
      specify { subject.inspect.should == expected.inspect }
    end
  end
    
end