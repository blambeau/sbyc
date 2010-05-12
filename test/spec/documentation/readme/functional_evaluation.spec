require File.expand_path('../../../spec_helper', __FILE__)

describe "README # object-evaluation section" do

  # expr = ::SByC::expr{ (display (concat x, y)) }    # (display (concat (? :x), (? :y)))
  # expr.apply(receiver, :x => 3, :y => 25)           # 325, executed as receiver.display(receiver.concat(x, y))

  let(:expr){ ::SByC::expr{ (display (concat x, y)) } }
  
  describe('what is said about the ast') do
    subject{ expr.to_s }
    it { should == "(display (concat (? :x), (? :y)))" }
  end
  
  describe("what is said about apply") do
    let(:receiver) {
      r = Object.new
      r.instance_eval <<-EOF
        def concat(*args)
          args.join
        end
        def display(arg)
          arg
        end
      EOF
      r
    }
    subject{ expr.apply(receiver, :x => 3, :y => 25)  }
    it { should == "325" }
  end
  
end