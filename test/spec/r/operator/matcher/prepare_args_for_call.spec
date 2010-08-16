require File.expand_path('../../../fixtures', __FILE__)
describe "R::Operator::Matcher.prepare_args_for_call" do
  
  describe "on an empty matcher" do
    let(:m){ R::Operator::Matcher.compile{ } }
    
    it "should match empty arguments" do
      m.prepare_args_for_call([ ]).should == [ ]
    end
    
    it "should not match too many arguments" do
      m.prepare_args_for_call([ true ]).should be_nil
    end

  end
  
  describe "on a single matcher" do
    let(:m){ R::Operator::Matcher.compile{ R::Boolean } }
    
    it "should match valid arguments" do
      m.prepare_args_for_call([ true ]).should == [ true ]
    end
    
    it "should not match too many arguments" do
      m.prepare_args_for_call([ true, false ]).should be_nil
    end

    it "should not match too few arguments" do
      m.prepare_args_for_call([  ]).should be_nil
    end

    it "should not match invalid arguments" do
      m.prepare_args_for_call([ "hello" ]).should be_nil
    end
  end

  describe "on a sequence matcher" do
    let(:m){ R::Operator::Matcher.compile{ (seq R::Symbol, R::Boolean) } }
    
    it "should match valid arguments" do
      m.prepare_args_for_call([ :hello, true ]).should == [ :hello, true ]
    end
    
    it "should not match too many arguments" do
      m.prepare_args_for_call([ :hello, true, false ]).should be_nil
    end
  
    it "should not match too few arguments" do
      m.prepare_args_for_call([  ]).should be_nil
    end
  
    it "should not match invalid arguments" do
      m.prepare_args_for_call([ :hello, "hello" ]).should be_nil
    end
  end
  
  describe "on a star matcher" do
    let(:m){ R::Operator::Matcher.compile{ (star R::Symbol) } }
    
    it "should match empty arguments" do
      m.prepare_args_for_call([  ]).should == []
    end
    
    it "should match singleton arguments" do
      m.prepare_args_for_call([ :hello ]).should == [ :hello ]
    end
    
    it "should match valid arguments" do
      m.prepare_args_for_call([ :hello, :world ]).should == [ :hello, :world ]
    end
    
    it "should not match invalid arguments" do
      m.prepare_args_for_call([ :hello, "world" ]).should be_nil
    end
    
  end
  
  describe "on a plus matcher" do
    let(:m){ R::Operator::Matcher.compile{ (plus R::Symbol) } }
    
    it "should not match empty arguments" do
      m.prepare_args_for_call([  ]).should be_nil
    end
    
    it "should match singleton arguments" do
      m.prepare_args_for_call([ :hello ]).should == [ :hello ]
    end
    
    it "should match valid arguments" do
      m.prepare_args_for_call([ :hello, :world ]).should == [ :hello, :world ]
    end
    
    it "should not match invalid arguments" do
      m.prepare_args_for_call([ :hello, "world" ]).should be_nil
    end
    
  end
  
  describe "on a somewhat complex matcher" do
    let(:m){ R::Operator::Matcher.compile{ (seq R::String, (plus (seq R::Symbol, R::Integer))) } }
    
    it "should not match empty arguments" do
      m.prepare_args_for_call([  ]).should be_nil
    end
  
    it "should match singleton pair" do
      m.prepare_args_for_call([ "Name", :hello, 12 ]).should == [ "Name", [ [:hello, 12] ] ]
    end
  
    it "should match valid pairs" do
      m.prepare_args_for_call([ "Name", :hello, 12, :world, 14 ]).should == [ "Name", [[:hello, 12], [:world, 14]] ]
    end
    
    it "should not match invalid pairs" do
      m.prepare_args_for_call([ "Name", :hello, 12, :world, "14" ]).should be_nil
    end
    
  end
  
end