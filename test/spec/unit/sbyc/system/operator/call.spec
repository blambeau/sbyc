require File.expand_path('../../../../../spec_helper', __FILE__)

describe "SByC::System::Operator#call" do
  
  let(:signature) { ::SByC::System::Signature.coerce([[String, String], String]) } 
  
  context "without a block" do
    let(:code)      { "a1.+(a2)"                                                        }
    let(:op)        { ::SByC::System::Operator.new(:plus, signature, code)      }
    subject { op.call("a", "b") }
    it { pending("Operator#call has been removed") { should == "ab" } }
  end
  
end