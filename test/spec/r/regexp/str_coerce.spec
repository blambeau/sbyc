require File.expand_path('../../fixtures', __FILE__)
describe "R::Regexp.str_coerce" do
  
  SByC::Fixtures::R::REGEXPS.each{|i|
    it "should not raise error on fixnum #{i}" do
      i.inspect =~ /^\/(.*)\/$/
      R::Regexp.str_coerce($1).should == i
    end
  }
  
end
