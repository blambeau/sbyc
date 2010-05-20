require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Matcher#match" do
  
  context "when called on something that matches" do
    let(:matcher) { CodeTree::matcher{ (match :say, x) } }
    let(:matched) { CodeTree::parse  { (say "hello")   } }
    subject{ matcher =~ matched }
    it { should_not be_nil }
    specify{ subject[:x].should == CodeTree::parse{"hello"} }
  end
  
  context "when called on something that does not match" do
    let(:matcher) { CodeTree::matcher{ (match :say, x) } }
    let(:matched) { CodeTree::parse  { (nosay "hello") } }
    subject{ matcher =~ matched }
    it { should be_nil }
  end
  
  context "a generic matcher" do
    let(:matcher) { CodeTree::matcher{ (match x, y[]) } }
    
    context 'against a ruby object' do
      let(:expr) { 12               }
      subject    { matcher =~ expr  }
      it         { should be_nil    }
    end
    
    context 'against a literal' do
      let(:expr) { CodeTree::parse{ 12 } }
      subject    { matcher =~ expr   }
      it         { should_not be_nil }
      specify    { subject[:x].should == :_ }
      specify    { subject[:y].should == [12] }
    end

    context 'against a variable' do
      let(:expr) { CodeTree::parse{ var } }
      subject    { matcher =~ expr    }
      it         { should_not be_nil  }
      specify    { subject[:x].should == :'?'   }
      specify    { subject[:y].should == [ CodeTree::parse{ :var }] }
    end
    
    context 'against a function with one literal argument' do
      let(:expr) { CodeTree::parse{ (func "a") } }
      subject    { matcher =~ expr    }
      it         { should_not be_nil  }
      specify    { subject[:x].should == :func }
      specify    { subject[:y].should == [ CodeTree::parse{ "a" } ] }
    end
    
    context 'against a function with two arguments' do
      let(:expr) { CodeTree::parse{ (func "a", b) } }
      subject    { matcher =~ expr    }
      it         { should_not be_nil  }
      specify    { subject[:x].should == :func }
      specify    { subject[:y].should == [ CodeTree::parse{ "a" }, CodeTree::parse{ b } ] }
    end
    
  end
  
end

