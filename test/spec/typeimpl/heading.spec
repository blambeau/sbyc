require 'sbyc'
describe ::SByC::Heading do 
  
  it "should detect wrong instantiations" do
    lambda { ::SByC::Heading.new() }.should raise_error(ArgumentError)
    lambda { ::SByC::Heading.new("blabla") }.should raise_error(ArgumentError)
    lambda { ::SByC::Heading.new("hello" => "world") }.should raise_error(ArgumentError)
    lambda { ::SByC::Heading.new(:hello => "world") }.should raise_error(ArgumentError)
    lambda { ::SByC::Heading.new(:width => Fixnum) }.should_not raise_error
  end
  
  it "should give access to components" do
    h = ::SByC::Heading.new(:width => Fixnum, :name => String)
    h.type_of(:width).should == Fixnum
    h.type_of(:name).should == String
  end
  
  it "should provide component query utilities" do
    h = ::SByC::Heading.new(:width => Fixnum, :name => String)
    h.has_attribute?(:width).should be_true
    h.has_attribute?(:length).should be_false
  end
  
  it "should help checking valid 'tuples'" do
    h = ::SByC::Heading.new(:width => Fixnum, :name => String)
    h.is_valid_tuple?(:width => 10, :name => "blabla").should be_true
    h.is_valid_tuple?().should be_false
    h.is_valid_tuple?(:width => 10).should be_false
    h.is_valid_tuple?(:width => "blabla", :name => "blabla").should be_false
  end
  
  it "should provide a selection helper" do
    natural = Fixnum.such_that{|i| i > 0}
    h = ::SByC::Heading.new(:width => natural, :name => String)
    h.selector_helper(:width => 10, :name => "blabla").should == {:width => 10, :name => "blabla"}
    lambda { h.selector_helper(:width => -1, :name => "blabla") }.should raise_error(::SByC::TypeError)
  end
  
end