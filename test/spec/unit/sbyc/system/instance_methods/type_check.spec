require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::System#type_check" do
  
  let(:system) { ::SByC::System.new }
  before(:all) do
    system.add_operator(:plus, [String,  String],  String, "a1.+(a2)")
    system.add_operator(:plus, [Integer, Integer], Integer, "a1.+(a2)")
    system.add_operator(:tos,  [Object], String, "a1.to_s()")
  end
  
  describe("with String arguments") {
    let(:expr) { proc{ (plus "a", "b") } }
    let(:tree) { ::SByC::CodeTree::parse(expr) }
    subject { system.type_check(tree) }
    specify { subject.return_type.should == String }
  }
  
  describe("with Integer arguments") {
    let(:expr) { proc{ (plus 1, 15) } }
    let(:tree) { ::SByC::CodeTree::parse(expr) }
    subject { system.type_check(tree) }
    specify { subject.return_type.should == Integer }
  }
  
  describe("with a mix of Integer and String") {
    let(:expr) { proc{ (plus (tos 1), "15") } }
    let(:tree) { ::SByC::CodeTree::parse(expr) }
    subject { system.type_check(tree) }
    specify { subject.return_type.should == String }
  }
  
  describe("with a something invalid") {
    let(:expr) { proc{ (plus (tos 1), 15) } }
    let(:tree) { ::SByC::CodeTree::parse(expr) }
    subject { proc { system.type_check(tree) } }
    it { should raise_error(::SByC::TypeCheckingError) }
    specify { 
      begin
        subject.call
      rescue ::SByC::TypeCheckingError => ex
        ex.message.should == "Unable to find operator (plus String, Fixnum)"
      end 
    }
  }
  
  it("should support shorthands") {
    system.type_check{ (plus (tos 1), "15") }.return_type.should == String
  }
  
end