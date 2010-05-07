require File.expand_path('../../../../../spec_helper', __FILE__)

describe "::SByC::System#is_ancestor_class?" do
  
  context("with same class") do
    subject { ::SByC::System::is_ancestor_class?(String, String) }
    it { should be_true }
  end
  
  context("with sub class") do
    subject { ::SByC::System::is_ancestor_class?(Integer, Fixnum) }
    it { should be_true }
  end
  
  context("with not a sub class") do
    subject { ::SByC::System::is_ancestor_class?(Integer, String) }
    it { should be_false }
  end
  
end
  
