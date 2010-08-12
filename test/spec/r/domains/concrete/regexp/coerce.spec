require File.expand_path('../../fixtures', __FILE__)
describe "R::Regexp.coerce" do
  
  SByC::Fixtures::R::REGEXPS.each{|i|
    it "should not raise error on #{i.inspect}" do
      i.inspect =~ /^\/(.*)\/$/
      R::Regexp.coerce($1).should == i
    end
  }
  
end
