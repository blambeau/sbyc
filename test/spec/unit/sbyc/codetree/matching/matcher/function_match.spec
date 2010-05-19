require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Matcher#function_match" do

  context "called with a literal match" do
    let(:match)  { CodeTree::parse{ (match :hello)  } }
    let(:victim) { CodeTree::parse{ (hello "world") } }
    let(:match_data) { Hash.new }

    subject{ ::CodeTree::Matcher.new(match).function_match(match, victim, match_data) }
    
    specify { 
      subject.should == true 
      match_data.should == {}
    }
  end

  context "called with a capture match" do
    let(:match)  { CodeTree::parse{ (match something)  } }
    let(:victim) { CodeTree::parse{ (hello "world") } }
    let(:match_data) { Hash.new }

    subject{ ::CodeTree::Matcher.new(match).function_match(match, victim, match_data) }
    
    specify { 
      subject.should == true
      match_data.should == {:something => :hello} 
    }
  end

  context "called without match" do
    let(:match)  { CodeTree::parse{ (match :hello)  } }
    let(:victim) { CodeTree::parse{ (i "world") } }
    let(:match_data) { Hash.new }

    subject{ ::CodeTree::Matcher.new(match).function_match(match, victim, match_data) }
    
    specify { 
      subject.should == false 
      match_data.should == {}
    }
  end

end
  
