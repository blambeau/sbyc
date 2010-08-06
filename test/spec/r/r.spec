require File.expand_path('../fixtures', __FILE__)
Dir[File.join(File.dirname(__FILE__), 'shared/**/*.spec')].each{|f| Kernel.load(f)}
describe "R" do
  
  SByC::Fixtures::R::DOMAINS.each{|i|
    subject{ i }
    it_should_behave_like("A domain")
  }
  
  SByC::Fixtures::R::PRINSTINE_DOMAINS.each{|i|
    subject{ i }
    it_should_behave_like("A prinstine domain")
  }
  
end