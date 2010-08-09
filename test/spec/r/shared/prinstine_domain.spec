require File.expand_path('../../fixtures', __FILE__)
shared_examples_for("A prinstine domain") do
  
  it "should respond Domain to domain message" do
    subject.domain.should == SByC::R::Domain
  end
  
end