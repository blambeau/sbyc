require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::ImperativeParser#parse" do
  
  context("with a simple method call") do
    subject { ::SByC::CodeTree::ImperativeParser::parse(code).inspect }

    let(:code)        { proc {|t| t[:a] + 12       } }
    let(:functional)  { proc { (plus (ref :a), 12) } }

    it { should == ::SByC::CodeTree::FunctionalParser::parse(functional).inspect  }
  end
  
  context("with left literal at left") do
    subject { ::SByC::CodeTree::ImperativeParser::parse(code).inspect }

    let(:code)        { proc {|t| 12 + t[:a]       } }
    let(:functional)  { proc { (plus (ref :a), 12) } }

    it { should == ::SByC::CodeTree::FunctionalParser::parse(functional).inspect  }
  end
    
end