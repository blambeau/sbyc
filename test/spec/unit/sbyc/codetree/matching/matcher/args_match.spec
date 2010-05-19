require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Matcher#args_match" do

  let(:imatch) { CodeTree::Matcher.new nil }

  context "when called with a capture match" do
    let(:matcher)    { CodeTree::parse{ x }  }
    let(:matched)    { CodeTree::parse{ 12 } }
    let(:match_data) { { }                 }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify {
      subject.should be_true
      match_data[:x].should == matched
    }
  end

  context "when called with a literal match" do
    let(:matcher)    { CodeTree::parse{ 12 }  }
    let(:matched)    { CodeTree::parse{ 12 } }
    let(:match_data) { { }                 }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify { subject.should be_true }
  end

  context "when called with a literal no-match" do
    let(:matcher)    { CodeTree::parse{ 13 }  }
    let(:matched)    { CodeTree::parse{ 12 } }
    let(:match_data) { { }                 }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify { subject.should be_false }
  end
  
  context "when called with a recursive match" do
    let(:matcher)    { CodeTree::parse{ (match :hello, x) } }
    let(:matched)    { CodeTree::parse{ (hello "You")   } }
    let(:match_data) { { }                             }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify { 
      subject.should be_true 
      match_data[:x].should == CodeTree::parse{ "You" }
    }
  end

  context "when called with a recursive match with varargs and one arg" do
    let(:matcher)    { CodeTree::parse{ (match :hello, x[]) } }
    let(:matched)    { CodeTree::parse{ (hello "You")      } }
    let(:match_data) { { }                                }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify { 
      subject.should be_true 
      match_data[:x].should == [ CodeTree::parse{ "You"} ]
    }
  end

  context "when called with a recursive match with varargs and many args" do
    let(:matcher)    { CodeTree::parse{ (match :hello, x[])            } }
    let(:matched)    { CodeTree::parse{ (hello "You", "and", 'world') } }
    let(:match_data) { { }                                           }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify { 
      subject.should be_true 
      match_data[:x].should == [ CodeTree::parse{ "You"}, CodeTree::parse{ "and"}, CodeTree::parse{ "world"} ]
    }
  end

  context "when called with a recursive no-match with empty varargs" do
    let(:matcher)    { CodeTree::parse{ (match :hello, x, y[]) } }
    let(:matched)    { CodeTree::parse{ (hello "You")         } }
    let(:match_data) { { }                                   }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify { subject.should be_false }
  end

  context "when called with a recursive no-match" do
    let(:matcher)    { CodeTree::parse{ (match :hello, "world") } }
    let(:matched)    { CodeTree::parse{ (hello 12)              } }
    let(:match_data) { { }                             }
    let(:subject) { imatch.args_match([ matcher ], [ matched ], match_data)}
    
    specify { subject.should be_false }
  end

end