require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::ImperativeParser#parse" do
  
  subject { ::SByC::CodeTree::ImperativeParser::parse(code).inspect }
  let(:functional) { proc { (plus (get :a), 12) } }
  let(:expected) { ::SByC::CodeTree::FunctionalParser::parse(functional).inspect }

  context("with a simple operator call") do
    let(:code)        { proc {|t| t[:a] + 12       } }

    it { should == expected}
  end
  
  context("with a simple method call") do
    let(:code)        { proc {|t| t[:a].plus(12)   } }

    it { should == expected}
  end
  
  context("with left literal at left") do
    let(:code)        { proc {|t| 12 + t[:a]       } }

    it { should == expected}
  end
    
end