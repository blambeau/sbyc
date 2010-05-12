require File.expand_path('../../../spec_helper', __FILE__)

describe "README # virtual blocks section" do

  let(:code)     { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)} }
  let(:ast)      { SByC::parse(code)                       }
  let(:compiled) { SByC::RubySystem::compile(code)         }
  let(:expected) { "(& (> (? :x), 5), (<= (? :z), 10))" }

  describe "what is said about the parsing stage" do
    subject    { ast.to_s }
    it { should == expected }
  end

  describe "what is said about styles" do
    let(:hash_style)       { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)                  } }
    let(:object_style)     { lambda{|t| (t.x > 5) & (t.z <= 10)                      } }
    let(:context_style)    { lambda{ (x > 5) & (z <= 10)                             } }
    let(:tested)           { [hash_style, object_style, context_style] }
    
    subject{ tested.collect{|t| ::SByC::parse(t) } }
    
    specify{ subject.collect{|c| c.to_s}.uniq.should == [ expected ] }
  end
  
  describe "what is said about functional style" do
    let(:functional)    { lambda{ (_and (gt x, 5), (let z, 10)) } }
    
    subject { SByC::parse(functional) }
    
    specify{ subject.to_s.should == "(_and (gt (? :x), 5), (let (? :z), 10))" }
  end
  
end