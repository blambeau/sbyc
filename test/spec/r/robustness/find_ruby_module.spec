require File.expand_path('../../fixtures', __FILE__)
describe "SByC::Typing::Robustness.find_ruby_module" do
  
  let(:r){ SByC::Typing::Robustness }
  
  describe 'with default start (Kernel)' do
    SByC::Fixtures::R::MODULES.each{|i|
      it("should accept #{i.inspect}") do 
        r.__find_ruby_module__(i.name).should == i
      end
    }
  end
  
  describe 'with a specifc start (SByC::Typing)' do
    ['Robustness', 'R::Boolean'].each{|i|
      it("should correctly resolve #{i.inspect}") do 
        real = Kernel.eval("SByC::Typing::#{i}")
        got  = r.__find_ruby_module__(i, SByC::Typing)
        got.should == real
      end
    }
  end
  
end