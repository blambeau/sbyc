require File.expand_path('../../../spec_helper', __FILE__)

describe "README # syntax section" do

  describe "what is said about imperative styles" do
    let(:expected) { "(& (> (? :x), 5), (<= (? :z), 10))" }

    let(:hash_style)       { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)                  } }
    let(:object_style)     { lambda{|t| (t.x > 5) & (t.z <= 10)                      } }
    let(:context_style)    { lambda{ (x > 5) & (z <= 10)                             } }
    let(:tested)           { [hash_style, object_style, context_style] }
    
    subject{ tested.collect{|t| ::SByC::parse(t) } }
    
    specify{ subject.collect{|c| c.to_s}.uniq.should == [ expected ] }
  end
  
  describe "what is said about functional style" do
    let(:functional)    { lambda{ (both (gt x, 5), (lte y, 10)) } }
    
    subject { SByC::parse(functional) }
    
    specify{ subject.to_s.should == "(both (gt (? :x), 5), (lte (? :y), 10))" }
  end
  
end