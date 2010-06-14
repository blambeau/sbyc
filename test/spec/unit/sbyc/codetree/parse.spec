require File.expand_path('../../../../spec_helper', __FILE__)
describe "CodeTree::parse" do
  
  let(:code)     { lambda { 
    (puts (to_s x)) 
    (say "hello")
  } }
  let(:expected){ ["(puts (to_s (? (_ :x))))", '(say (_ "hello"))'] }

  context "when called with a multiline option and proc as first" do
    subject { CodeTree::parse(code, :multiline => true) }
    specify{
      subject.collect{|s| s.inspect}.should == expected
    }
  end

  context "when called with a multiline option and proc as block, with nil as first" do
    subject { CodeTree::parse(nil, :multiline => true, &code) }
    specify{
      subject.collect{|s| s.inspect}.should == expected
    }
  end
  
  context "when called with a multiline option and proc as block, and nothing as first" do
    subject { CodeTree::parse(:multiline => true, &code) }
    specify{
      subject.collect{|s| s.inspect}.should == expected
    }
  end
  
end
  
