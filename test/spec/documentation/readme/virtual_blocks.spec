require File.expand_path('../../../spec_helper', __FILE__)

describe "README # virtual blocks section" do

  let(:code) { lambda{|t| (t[:x] > 5) & (t[:y] <= 10)} }
  let(:ast)  { SByC::parse_imperative(code)            }
  let(:compiled) { SByC::RubySystem::compile(code) }

  describe "what is said about the parsing stage" do
    subject    { ast.inspect }
    
    it { should == "(bool_and (gt (get :x), 5), (lte (get :y), 10))" }
  end

  describe "what is said about the ruby code generation" do
    subject { SByC::RubySystem::to_ruby_code(code) }
    
    specify { pending("Ruby system should be rewritten entirely") { puts subject } }
  end
  
  describe "what is said about the compilation stage" do
    subject { compiled.call(:x => 7, :y => 15) }
    
    it { pending("Ruby system should be rewritten entirely") { should be_false } }
  end
  
  describe "what is said about the type checker" do 
    subject { compiled.type_check(:x => 7, :y => 15) }
    
    it { pending("Ruby system should be rewritten entirely") { should == Integer} }
  end
  
end