require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::System::Signature#===" do
  
  context 'with a single class' do
    subject { ::SByC::System::Signature.coerce(Integer) }

    it { should be_kind_of(::SByC::System::Signature) }
    
    it ("should correctly match exact signatures") {
      subject.matches?([Integer]).should be_true
    }

    it ("should correctly match sub signatures") {
      subject.matches?([Fixnum]).should be_true
    }

    it("should correctly recognize valid signatures") { 
      (subject === [12]).should be_true
    }

    it("should correctly reject invalid signatures") { 
      (subject === nil).should be_false
      (subject === 12).should be_false
      (subject === "hello").should be_false
      (subject === ["hello"]).should be_false
      (subject === [12, 14]).should be_false
    }
  end
  
end