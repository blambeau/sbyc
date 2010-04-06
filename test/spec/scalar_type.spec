require 'sbyc'
describe ::SByC::ScalarType do
  
  # it "should allow creating simple types with a major anonymous physical representation" do
  #   mail = ::SByC::System::ScalarType(String){
  #     constraint{|m| m.physrep =~ /^[a-z]+@[a-z]+\.[a-z]{3}$/ }
  #   }
  #   lambda { mail["blambeau@gmail.com"] }.should_not raise_error(::SByC::TypeError)
  #   lambda { mail["hello"] }.should raise_error(::SByC::TypeError)
  # end
  # 
  # it "should allow creating simple types with multiple selectors" do
  #   mail = ::SByC::System::ScalarType() do
  #     constraint{|m| m.physrep =~ /^[a-z]+@[a-z]+\.[a-z]{3}$/}
  #     selector(String){|m, s| m.physrep = s                         }
  #     selector(String, String){|m, user, host| m.physrep = "#{user}@#{host}"}
  #   end
  #   (mail === mail["blambeau@gmail.com"]).should be_true
  #   (mail === mail["blambeau", "gmail.com"]).should be_true
  # end
  # 
  
  it "should allow creating complex types" do
    natural = Fixnum.such_that{|i| i > 0}
    rectangle = ::SByC::System::ScalarType(:width => natural, :length => natural)
    r = rectangle[:width => 10, :length => 10]
    (rectangle === r).should be_true
    # Square = Rectangle.such_that{|r| r.width == r.length}
    # r = Rectangle[:width => 10, :length => 10]
    # (Square === r).should be_true
  end
  
  it "should allow constraining complex types" do
    natural = Fixnum.such_that{|i| i > 0}
    rectangle = ::SByC::System::ScalarType(:width => natural, :length => natural)
    square = rectangle.such_that{|r| r.width == r.length}
    lambda {square[:width => 10, :length => 10]}.should_not raise_error
    lambda {square[:width => 10, :length => 0]}.should raise_error(::SByC::TypeError)
  end
  
end