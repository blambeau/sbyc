require File.expand_path('../../../../spec_helper', __FILE__)

describe "Boolean" do
  
  describe("with true") do
    subject { Boolean }
    it { should === true }
  end
  
  describe("with false") do
    subject { Boolean }
    it { should === false }
  end
  
end
  
