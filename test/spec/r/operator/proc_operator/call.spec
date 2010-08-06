require File.expand_path('../../../fixtures', __FILE__)
describe "R::ProcOperator.call" do
  
  describe "a monadic operator" do

    let(:op){ R::ProcOperator.new([R::Boolean], R::Boolean, lambda{|v| !v}) }
    
    specify{
      op.call([true]).should == false
    }  

    specify{
      op.call([false]).should == true
    }  

  end

  describe "a dyadic operator" do

    let(:op){ R::ProcOperator.new([R::Boolean, R::Boolean], R::Boolean, lambda{|i,j| "#{i}#{j}"}) }

    specify{
      op.call([true, true]).should == "truetrue"
    }  

    specify{
      op.call([true, false]).should == "truefalse"
    }  
    
  end
  
end