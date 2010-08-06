require File.expand_path('../../fixtures', __FILE__)
describe "R::find_operator_by_signature" do
  
  [ 
    [:~,   [R::Boolean],             R::Boolean],
    [:not, [R::Boolean],             R::Boolean],
    [:&,   [R::Boolean, R::Boolean], R::Boolean],
    [:and, [R::Boolean, R::Boolean], R::Boolean],
  ].each{|name, sign, returns|

    it "should find #{name} #{sign}" do
      op = R.find_operator_by_signature(name, sign)
      op.should_not be_nil
      op.result_domain.should == returns
    end

  }
  
end