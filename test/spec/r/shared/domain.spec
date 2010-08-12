require File.expand_path('../../fixtures', __FILE__)
shared_examples_for("A domain") do
  
  it{ should respond_to(:sbyc_domain)   }
  it{ should respond_to(:is_value?)     }
  it{ should respond_to(:parse_literal) }
  it{ should respond_to(:to_literal)    }
  it{ should respond_to(:coerce)        }
  
  it "should be a Domain" do
    subject.sbyc_domain.should == R::Domain
  end
  
  it "should have Alpha as super domain" do
    unless subject == R::Alpha
      subject.has_super_domain?(R::Alpha).should be_true
      subject.sub_domain_of?(R::Alpha).should be_true
    end
  end
  
  it "should have exemplars" do
    subject.exemplars.should_not be_empty
  end
  
  it "should have exemplars that are values" do
    subject.exemplars.all?{|x| subject.is_value?(x)}.should be_true
  end
  
  it "should support to_literal on all exemplars" do
    subject.exemplars.each{|e|
      lambda{ subject.to_literal(e) }.should_not raise_error
    }
  end
  
  it "should not return nil on to_literal" do
    subject.exemplars.each{|e|
      subject.to_literal(e).should_not be_nil
    }
  end
  
  it "should support literal roundtrip on all exemplars" do
    subject.exemplars.each{|e|
      subject.parse_literal(subject.to_literal(e)).should == e
    }
  end
  
  it "should have operators" do
    subject.const_get(:Operators).should_not be_nil
  end
  
end