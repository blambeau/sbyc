require File.expand_path('../../../../spec_helper', __FILE__)

describe "::SByC::Expr" do

  context "when passed an expr instance" do
    subject { ::SByC::Expr.coerce(::SByC::Expr.new(nil)) }
    
    it{ should be_kind_of(::SByC::Expr) }
  end  

  context "when passed an string" do
    subject { ::SByC::Expr.coerce("x > z") }
    
    it{ should be_kind_of(::SByC::Expr) }
    specify{ subject.ast.to_s.should == "(> (? :x), (? :z))" }
  end  
  
  context "when passed an ast" do
    subject { ::SByC::Expr.coerce(::SByC::parse{ x > z }) }
    
    it{ should be_kind_of(::SByC::Expr) }
    specify{ subject.ast.to_s.should == "(> (? :x), (? :z))" }
  end  
  
  context "when passed a block" do
    subject { ::SByC::Expr.coerce{ x > z } }
    
    it{ should be_kind_of(::SByC::Expr) }
    specify{ subject.ast.to_s.should == "(> (? :x), (? :z))" }
  end  

  context "when passed an expr" do
    subject { ::SByC::Expr.coerce(::SByC::expr{ x > z }) }
    
    it{ should be_kind_of(::SByC::Expr) }
    specify{ subject.ast.to_s.should == "(> (? :x), (? :z))" }
  end  

end