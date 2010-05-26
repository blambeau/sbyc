require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Name2X::Delegate.coerce" do

  subject{ CodeTree::Name2X::Delegate::coerce(arg) }
 
  context "When called on a Delegate instance" do
    let(:arg) { CodeTree::Name2X::Delegate.new({}) }
    it { should be_kind_of(CodeTree::Name2X::Delegate) }
  end

  context "When called on a hash" do
    let(:arg) { Hash.new }
    it { should be_kind_of(CodeTree::Name2X::Delegate) }
  end

  context "When called on a proc" do
    let(:arg) { Kernel.proc{|x| x} }
    it { should be_kind_of(CodeTree::Name2X::Delegate) }
  end

  context "When called on a module" do
    let(:arg) { CodeTree }
    it { should be_kind_of(CodeTree::Name2X::Delegate) }
  end

  context "When called on an object responding to :[]" do
    let(:arg) { o = Object.new; def o.[](name); end; o; }
    it { should be_kind_of(CodeTree::Name2X::Delegate) }
  end

  context "When called on something else" do
    let(:arg) { Object.new }
    subject{ lambda{ CodeTree::Name2X::Delegate::coerce(arg) } }
    it { should raise_error(ArgumentError) }
  end
  
end