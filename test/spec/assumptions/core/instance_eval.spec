describe "Assumptions about instance_eval" do

  it "should support passing no-args block" do
    p = lambda{ 12 }
    lambda{ 
      if RUBY_VERSION >= "1.9"
        Object.new.instance_exec(&p) 
      else
        Object.new.instance_eval(&p) 
      end
    }.should_not raise_error
  end
  
end