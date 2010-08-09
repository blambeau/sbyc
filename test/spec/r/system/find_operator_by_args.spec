require File.expand_path('../../fixtures', __FILE__)
describe "R::find_operator_by_args" do
  
  [ 
    [:~,   [true],         R::Boolean],
    [:not, [false],        R::Boolean],
    [:&,   [true, false],  R::Boolean],
    [:and, [false, false], R::Boolean],
  ].each{|name, args, returns|

    it "should find #{name} #{args.inspect}" do
      op = R.find_operator_by_args(name, args)
      op.should_not be_nil
      op.result_domain_by_heading(nil).should == returns
    end

  }
  
end