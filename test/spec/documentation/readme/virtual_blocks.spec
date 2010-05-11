require File.expand_path('../../../spec_helper', __FILE__)

describe "README # virtual blocks section" do

  let(:code)     { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)} }
  let(:ast)      { SByC::parse(code)            }
  let(:compiled) { SByC::RubySystem::compile(code)         }
  let(:expected) { "(bool_and (gt (get :x), 5), (lte (get :z), 10))" }

  describe "what is said about the parsing stage" do
    subject    { ast.inspect }
    
    it { should == expected }
  end

  describe "what is said about styles" do
    let(:hash_style)       { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)                  } }
    let(:object_style)     { lambda{|t| (t.x > 5) & (t.z <= 10)                      } }
    let(:context_style)    { lambda{ (x > 5) & (z <= 10)                             } }
    let(:functional_style) { lambda{ (bool_and (gt (get :x), 5), (lte (get :z), 10)) } }
    let(:functional_style_2) { lambda{ (bool_and (gt x, 5), (lte z, 10)) } }
    let(:tested)           { [hash_style, object_style, context_style, functional_style, functional_style_2] }
    
    subject{ tested.collect{|t| ::SByC::parse(t) } }
    
    specify{ subject.collect{|c| c.inspect}.uniq.should == [ expected ] }
  end
  
end