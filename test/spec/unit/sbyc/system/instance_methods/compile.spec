require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::System#compile" do
  
  let(:system) { ::SByC::System.new }
  before(:all) do
    system.add_operator(:plus, [[String,  String],  String], "$0.+($1)")
    system.add_operator(:plus, [[Integer, Integer], Integer], "$0.+($1)")
    system.add_operator(:tos,  [[Object], String], "$0.to_s()")
    system.add_operator(:toi,  [[String], Integer], "$0.to_i()")
  end
  
  describe("with String arguments") {
    let(:expr) { proc{ (plus "a", "b") } }
    subject { system.compile(expr) }
    specify { subject.call.should == "ab" }
  }
  
  describe("with Integer arguments") {
    let(:expr) { proc{ (plus 1, 15) } }
    subject { system.compile(expr) }
    specify { subject.call.should == 16 }
  }
  
  describe("with a mix of Integer and String") {
    let(:expr) { proc{ (plus (tos 1), "15") } }
    subject { system.compile(expr) }
    specify { subject.call.should == '115' }
  }
  
  describe("with a mix of Integer and String, second") {
    let(:expr) { proc{ (plus (toi (tos 1)), (toi "15")) } }
    subject { system.compile(expr) }
    specify { subject.call.should == 16 }
  }

end