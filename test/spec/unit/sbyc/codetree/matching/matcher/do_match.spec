require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Matcher#match" do
  
  context 'When capture are provided' do
    let(:matcher)    { CodeTree::parse{ (match :hello, (match :whos, x, y)) } } 
    let(:matched)    { CodeTree::parse{ (hello (whos "world", "others"))    } }
    let(:subject)    { CodeTree::Matcher.new(matcher) =~ matched       }
    specify {
      subject[:x].literal.should == "world"
      subject[:y].literal.should == "others"
    }
  end
  
  context "When applying correct matches" do 
    [ 
      [CodeTree::parse{ (match :hello, "world") }, CodeTree::parse{ (hello "world") }],
      [CodeTree::parse{ (match :hello, x)       }, CodeTree::parse{ (hello "world") }],
      [CodeTree::parse{ (match :hello, x, y, z) }, CodeTree::parse{ (hello "world", "and", "others") }],
      [CodeTree::parse{ (match :hello, (match :world, x)) }, CodeTree::parse{ (hello (world "I")) }],
    ].each do |matcher, matched|
      let(:subject){ CodeTree::Matcher.new(matcher) =~ matched }
      it { should_not be_nil }
    end
  end
  
  context "When applying incorrect matches" do
    [ 
      [CodeTree::parse{ (match :hello, "world") }, CodeTree::parse{ (hello 12) }],
      [CodeTree::parse{ (match :hello, "world") }, CodeTree::parse{ (hello "world", "and", "others") }],
      [CodeTree::parse{ (match :hello, (match :world, x)) }, CodeTree::parse{ (hello "world") }],
    ].each do |matcher, matched|
      let(:subject){ CodeTree::Matcher.new(matcher) =~ matched }
      it { should be_nil }
    end
  end
  
end

