require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::ProcParser#parse" do
  
  subject { CodeTree::ProcParser::parse(code) }

  context "when called with an argument" do 
    let(:expected)   { "(+ (? (_ :a)), (_ 12))" }
  
    context("with a simple literal") do
      let(:code)  { proc {|t| 12 } }
      specify     { subject.should be_kind_of(CodeTree::AstNode) }
      specify     { subject.inspect.should == CodeTree::parse{ 12 }.inspect }
    end
  
    context("with a simple operator call") do
      let(:code)  { proc {|t| t[:a] + 12 }             }
      specify     { subject.inspect.should == expected }
    end
      
    context("with a simple operator call and dot heuristic") do
      let(:code)        { proc {|t| t.a + 12 } }
      specify { subject.inspect.should == expected }
    end
      
    context("with left literal at left") do
      let(:code)        { proc {|t| 12 + t[:a]       } }
      specify { subject.inspect.should == expected }
    end
      
    context("with left literal at left and dot heuristic") do
      let(:code)        { proc {|t| 12 + t.a       } }
      specify { subject.inspect.should == expected }
    end
  end
  
  context "when called without argument" do
    let(:expected)   { "(+ (? (_ :a)), (_ 12))" }
  
    context("with a simple literal") do
      let(:code)        { proc { 12 } }
      specify     { subject.should be_kind_of(CodeTree::AstNode) }
      specify { subject.inspect.should == CodeTree::parse{ 12 }.inspect }
    end
  
    context("with a simple operator call") do
      let(:code)        { proc { a + 12 } }
      specify { subject.inspect.should == expected }
    end
  
    context("with left literal at left") do
      let(:code)        { proc { 12 + a } }
      specify { subject.inspect.should == expected }
    end
  end
   
  context "when called and used with method calls" do
    let(:expected)   { "(plus (? (_ :a)), (_ 12))" }
   
    context("with a simple method call") do
      let(:code)        { proc {|t| t[:a].plus(12)   } }
      specify { subject.inspect.should == expected }
    end
      
    context("with a simple method call and dot heuristic") do
      let(:code)        { proc {|t| t.a.plus(12)   } }
      specify { subject.inspect.should == expected }
    end
  end
  
  context "when call on expressions that refer to ruby Kernel methods" do
    let(:expected) { "(puts (to_s (? (_ :x))))" }
    let(:code)     { lambda { (puts (to_s x)) } }
    specify{ subject.inspect.should == expected }
  end
  
  context "when call on expressions that refer to typical inherited methods/operators" do
    let(:expected) { "(== (hash (? (_ :x))), (_ 12))"}
    let(:code)     { lambda { x.hash == 12 } }
    specify{ subject.inspect.should == expected }
  end
  
  context "when called with a multiline option set to false" do
    let(:expected) { "(puts (to_s (? (_ :x))))" }
    let(:code)     { lambda { (puts (to_s x)) } }
    subject { CodeTree::ProcParser::parse(code, :multiline => false) }
    specify{
      subject.inspect.should == expected
    }
  end
  
  context "when called with a multiline option set to true" do
    let(:expected) { "(puts (to_s (? (_ :x))))" }
    let(:code)     { lambda { (puts (to_s x)) } }
    subject { CodeTree::ProcParser::parse(code, :multiline => true) }
    specify{
      subject.should be_kind_of(Array)
      subject[0].inspect.should == expected
    }
  end
  
  context "when called with a multiline option set to true and multiple lines" do
    let(:code)     { lambda { 
      (puts (to_s x)) 
      (say "hello")
    } }
    subject { CodeTree::ProcParser::parse(code, :multiline => true) }
    specify{
      subject.should be_kind_of(Array)
      subject.size.should == 2
      subject[0].inspect.should == "(puts (to_s (? (_ :x))))"
      subject[1].inspect.should == '(say (_ "hello"))'
    }
  end
  
end