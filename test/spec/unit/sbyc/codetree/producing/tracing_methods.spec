require File.expand_path('../../../../../spec_helper', __FILE__)

describe "CodeTree::Producing::TracingOptions" do
  
  let(:producer) {
    ::CodeTree::producer{|p|
      p.rule(:'_') do |engine, node|
        engine.trace("On: #{node.literal.inspect}")
      end
      p.rule("*") do |engine, node| 
        engine.trace_rule_entered("Before: #{node}")
        engine.apply(node.children)
        engine.trace_rule_exited("After: #{node}")
        nil
      end
    }
  }

  let(:expr) { CodeTree::parse{ (concat "hello ", who) } }

  subject { producer.tracing_options[:io] }
  
  context("With default options but io") do
    before do 
      producer.add_extension(::CodeTree::Producing::TracingMethods, :io => [])
      producer.apply(expr)
    end
    it { should == ['Before: (concat "hello ", who)' + "\n",
                    '  On: "hello "' + "\n",
                    '  Before: who' + "\n",
                    '    On: :who' + "\n",
                    '  After: who' + "\n",
                    'After: (concat "hello ", who)' + "\n"] }
  end
  
end