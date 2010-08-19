require File.expand_path('../fixtures', __FILE__)
Dir[File.join(File.dirname(__FILE__), 'shared/**/*.spec')].each{|f| Kernel.load(f)}
describe "R" do
  
  it "should have expected constants" do
    R.const_get(:Boolean).should_not be_nil
  end
  
  it "expected constants should be domain" do
    R.const_get(:Boolean).should be_kind_of(::Class)
    R.const_get(:Boolean).sbyc_domain.should == R::Domain
  end
  
  it "should have expected domains" do
    R.domains.include?(R::Boolean).should be_true
  end
  
end