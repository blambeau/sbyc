require File.expand_path('../../../spec_helper', __FILE__)

describe "README # virtual blocks section" do

  let(:code)     { lambda{|t| (t[:x] > 5) & (t[:z] <= 10)} }
  let(:ast)      { SByC::parse_imperative(code)            }
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
    let(:tested)           { [hash_style, object_style, context_style, functional_style] }
    
    subject{ tested.collect{|t| ::SByC::parse_imperative(t) } }
    
    specify{ subject.collect{|c| c.inspect}.uniq.should == [ expected ] }
  end
  
  describe "what is said about the ruby code generation" do
    subject { SByC::RubySystem::to_ruby_code(code) }
    
    specify { pending("Ruby system should be rewritten entirely") { puts subject } }
  end
  
  describe "what is said about the compilation stage" do
    subject { compiled.call(:x => 7, :z => 15) }
    
    it { pending("Ruby system should be rewritten entirely") { should be_false } }
  end
  
  describe "what is said about the type checker" do 
    subject { compiled.type_check(:x => 7, :z => 15) }
    
    it { pending("Ruby system should be rewritten entirely") { should == Integer} }
  end
  
end