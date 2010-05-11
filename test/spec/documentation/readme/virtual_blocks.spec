require File.expand_path('../../../spec_helper', __FILE__)

describe "README # virtual blocks section" do

  let(:code)     { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)} }
  let(:ast)      { SByC::parse(code)            }
  let(:compiled) { SByC::RubySystem::compile(code)         }
  let(:expected) { "(& (> (__scope_get__ :x), 5), (<= (__scope_get__ :z), 10))" }

  describe "what is said about the parsing stage" do
    subject    { ast.inspect }
    
    it { should == expected }
  end

  describe "what is said about styles" do
    let(:hash_style)       { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)                  } }
    let(:object_style)     { lambda{|t| (t.x > 5) & (t.z <= 10)                      } }
    let(:context_style)    { lambda{ (x > 5) & (z <= 10)                             } }
    let(:tested)           { [hash_style, object_style, context_style] }
    
    subject{ tested.collect{|t| ::SByC::parse(t) } }
    
    specify{ subject.collect{|c| c.inspect}.uniq.should == [ expected ] }
  end
  
  describe "what is said about functional style" do
    let(:functional)    { lambda{ (_and (gt x, 5), (let z, 10)) } }
    
    subject { SByC::parse(functional) }
    
    specify{ subject.inspect.should == "(_and (gt (__scope_get__ :x), 5), (let (__scope_get__ :z), 10))" }
  end
  
end