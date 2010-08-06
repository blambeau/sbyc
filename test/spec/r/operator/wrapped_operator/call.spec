require File.expand_path('../../../fixtures', __FILE__)
describe "R::WrappedOperator.call" do
  
  describe "a monadic operator" do

    let(:op){ R::WrappedOperator.new([R::Boolean], R::String, :to_s) }
    
    specify{
      op.call([true]).should == 'true'
    }  

    specify{
      op.call([false]).should == 'false'
    }  

  end

  describe "a dyadic operator" do

    let(:op){ R::WrappedOperator.new([R::Boolean, R::Boolean], R::Boolean, :&) }

    specify{
      op.call([true, true]).should == true
    }  

    specify{
      op.call([true, false]).should == false
    }  
    
  end
  
end