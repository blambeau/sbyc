require File.expand_path('../fixtures', __FILE__)
Dir[File.join(File.dirname(__FILE__), 'shared/**/*.spec')].each{|f| Kernel.load(f)}
describe "R" do
  
  it "should have expected domains" do
    R.domains.include?(R::Boolean).should be_true
  end
  
  SByC::Fixtures::R::DOMAINS.each{|i|
    subject{ i }
    it_should_behave_like("A domain")
  }
  
  Dir[File.expand_path('../r_scripts/**/*.r', __FILE__)].each{|f|
    it "should run #{f} without errors" do
      runner = R::SpecRunner.new
      runner.run(File.read(f))
      puts "\n#{runner}"
      runner.should_not have_failure
    end
  }
  
end