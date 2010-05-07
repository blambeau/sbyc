require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::System::Signature#coerce" do
  
  context 'with a single class' do
    subject { ::SByC::System::Signature.coerce([[Integer], NilClass]) }

    it { should be_kind_of(::SByC::System::Signature) }

    specify { subject.arg_types.should == [Integer] }
  end
  
  context 'with an array of classes' do
    subject { ::SByC::System::Signature.coerce([[Integer, String], NilClass]) }

    it { should be_kind_of(::SByC::System::Signature) }

    specify { subject.arg_types.should == [Integer, String] }
  end
  
end