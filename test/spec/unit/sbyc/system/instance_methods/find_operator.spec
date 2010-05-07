require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::System#find_operator" do
  
  let(:system) { ::SByC::System.new }
  before(:all) do
    system.add_operator(:plus, [[String,  String],  String], "a1.+(a2)")
    system.add_operator(:plus, [[Integer, Integer], Integer], "a1.+(a2)")
  end
  
  describe("with String arguments") {
    subject { system.find_operator(:plus, [String, String]) }
    specify { subject.return_type.should == String }
  }
  
  describe("with Integer arguments") {
    subject { system.find_operator(:plus, [Integer, Integer]) }
    specify { subject.return_type.should == Integer }
  }
  
  describe("with Integer/Fixnum arguments") {
    subject { system.find_operator(:plus, [Integer, Fixnum]) }
    specify { subject.return_type.should == Integer }
  }
  
end