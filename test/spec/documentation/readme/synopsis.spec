require File.expand_path('../../../spec_helper', __FILE__)

describe "README # synopsis section" do
  
  #
  # proc = SByC::proc{ x > y }
  # proc.ast                             # (> (? :x), (? :y))
  # proc.call(:x => 5, :y => 2)          # true
  #
  # dumped   = Marshal::dump(proc)
  # reloaded = Marshal::load(dumped)
  #
  # reloaded.ast                         # (> (? :x), (? :y))
  # reloaded.call(:x => 5, :y => 2)      # true
  #
  context "what is said about Marshal-able proc" do
    let(:proc)     { SByC::expr{ x > y }                  }
    let(:reloaded) { Marshal::load(Marshal::dump(proc))   }
    
    specify{ proc.should be_kind_of(::SByC::Expr)        }
    specify{ proc.ast.to_s.should == "(> (? :x), (? :y))" }
    specify{ proc.call(:x => 5, :y => 2).should == true   }
    
    specify{ reloaded.should be_kind_of(::SByC::Expr)        }
    specify{ reloaded.ast.to_s.should == "(> (? :x), (? :y))" }
    specify{ reloaded.call(:x => 5, :y => 2).should == true   }
  end
  
end
  
