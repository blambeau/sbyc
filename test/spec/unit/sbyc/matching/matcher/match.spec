require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::Matching::Matcher#match" do
  
  
  context "When matching pure literal ASTs" do
    specify("Matching pure literals should work") {
      pending {
        let(:matcher) { ::SByC::parse{ (match 12) } }
        let(:matched) { ::SByC::parse{ 12 }         }
        subject{ SByC::Matching::Matcher.new(matcher) =~ matched }
        it { should_not be_nil }
      }
    }
  end
  
  context 'When capture are provided' do
    let(:matcher)    { ::SByC::parse{ (match :hello, (match :whos, x, y)) } } 
    let(:matched)    { ::SByC::parse{ (hello (whos "world", "others"))    } }
    let(:subject)    { SByC::Matching::Matcher.new(matcher) =~ matched       }
    specify {
      subject[:x].literal.should == "world"
      subject[:y].literal.should == "others"
    }
  end
  
  context "When applying correct matches" do 
    [ 
      [::SByC::parse{ (match :hello, "world") }, ::SByC::parse{ (hello "world") }],
      [::SByC::parse{ (match :hello, x)       }, ::SByC::parse{ (hello "world") }],
      [::SByC::parse{ (match :hello, x, y, z) }, ::SByC::parse{ (hello "world", "and", "others") }],
      [::SByC::parse{ (match :hello, (match :world, x)) }, ::SByC::parse{ (hello (world "I")) }],
    ].each do |matcher, matched|
      let(:subject){ SByC::Matching::Matcher.new(matcher) =~ matched }
      it { should_not be_nil }
    end
  end
  
  context "When applying incorrect matches" do
    [ 
      [::SByC::parse{ (match :hello, "world") }, ::SByC::parse{ (hello 12) }],
      [::SByC::parse{ (match :hello, "world") }, ::SByC::parse{ (hello "world", "and", "others") }],
      [::SByC::parse{ (match :hello, (match :world, x)) }, ::SByC::parse{ (hello "world") }],
    ].each do |matcher, matched|
      let(:subject){ SByC::Matching::Matcher.new(matcher) =~ matched }
      it { should be_nil }
    end
  end
  
end

