require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::CodeTree::ImperativeParser#parse" do
  
  context("with a simple method call") do
    let(:code)        { proc {|t| t[:a] + 12       } }
    let(:functional)  { proc { (plus (ref :a), 12) } }
    subject { ::SByC::CodeTree::ImperativeParser::parse(code).inspect }
    it { 
      should == ::SByC::CodeTree::FunctionalParser::parse(functional).inspect 
    }
  end
    
end