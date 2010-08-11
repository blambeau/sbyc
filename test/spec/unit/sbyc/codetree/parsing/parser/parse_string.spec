require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_string" do
  
  let(:parser){ CodeTree::Parsing::Parser.new(text) }
  
  describe "when the string is present and no eat spaces" do
    let(:text){ "hello   " }
    specify{ 
      parser.parse_string(text.strip).should == text.strip
      parser.index.should == text.strip.length
    }
  end
  
  describe "when the string is present and eat spaces" do
    let(:text){ "hello   " }
    specify{ 
      parser.parse_string(text.strip, true).should == text.strip
      parser.index.should == text.length
    }
  end
  
end