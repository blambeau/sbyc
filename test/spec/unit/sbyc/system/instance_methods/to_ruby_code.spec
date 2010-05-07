require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::System#to_ruby_code" do
  
  let(:system) { ::SByC::System.new }
  before(:all) do
    system.add_operator(:plus, [String,  String],  String, "$0.+($1)")
    system.add_operator(:plus, [Integer, Integer], Integer, "$0.+($1)")
    system.add_operator(:tos,  [Object], String, "$0.to_s()")
  end
  
  describe("with String arguments") {
    let(:expr) { proc{ (plus "a", "b") } }
    let(:tree) { ::SByC::CodeTree::parse(expr) }
    subject { system.to_ruby_code(tree) }
    specify { subject.should == '"a".+("b")' }
  }
  
  describe("with Integer arguments") {
    let(:expr) { proc{ (plus 1, 15) } }
    let(:tree) { ::SByC::CodeTree::parse(expr) }
    subject { system.to_ruby_code(tree) }
    specify { subject.should == '1.+(15)' }
  }
  
  describe("with a mix of Integer and String") {
    let(:expr) { proc{ (plus (tos 1), "15") } }
    let(:tree) { ::SByC::CodeTree::parse(expr) }
    subject { system.to_ruby_code(tree) }
    specify { subject.should == '1.to_s().+("15")' }
  }
  
  it("should support shorthands") {
    system.to_ruby_code{ (plus (tos 1), "15") }.should == '1.to_s().+("15")'
  }

end