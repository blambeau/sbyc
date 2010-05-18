require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Rewriter::IMatch#function_match" do

  context "called with a literal match" do
    let(:match)  { ::SByC::parse{ (match :hello)  } }
    let(:victim) { ::SByC::parse{ (hello "world") } }
    let(:match_data) { Hash.new }

    subject{ ::SByC::Matching::Matcher.new(match).function_match(match, victim, match_data) }
    
    specify { 
      subject.should == true 
      match_data.should == {}
    }
  end

  context "called with a capture match" do
    let(:match)  { ::SByC::parse{ (match something)  } }
    let(:victim) { ::SByC::parse{ (hello "world") } }
    let(:match_data) { Hash.new }

    subject{ ::SByC::Matching::Matcher.new(match).function_match(match, victim, match_data) }
    
    specify { 
      subject.should == true
      match_data.should == {:something => :hello} 
    }
  end

  context "called without match" do
    let(:match)  { ::SByC::parse{ (match :hello)  } }
    let(:victim) { ::SByC::parse{ (i "world") } }
    let(:match_data) { Hash.new }

    subject{ ::SByC::Matching::Matcher.new(match).function_match(match, victim, match_data) }
    
    specify { 
      subject.should == false 
      match_data.should == {}
    }
  end

end
  
