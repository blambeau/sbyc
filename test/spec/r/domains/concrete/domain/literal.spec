require File.expand_path('../../fixtures', __FILE__)
describe "R::Domain.parse_literal" do
  
  it "should support resolving R simple domains by name" do
    R::Domain.parse_literal('Boolean').should == R::Boolean
  end
  
  SByC::Fixtures::R::DOMAIN_NAMES.each{|i|
    it "should correctly resolve #{i.inspect}" do
      got = R::Domain.parse_literal(i)
      got.should_not be_nil
      got.should be_kind_of(Class)
    end
  }

  SByC::Fixtures::R::DOMAINS.each{|i|
    it "should not raise error on #{i.inspect}" do
      R::Domain.parse_literal(R::Domain.to_literal(i)).should == i
    end
  }

  it "should support resolving R generated domains" do
    decoded = R::Domain.parse_literal('Array<Boolean>')
    decoded.should_not be_nil
    decoded.sbyc_domain.should == R::Domain
    decoded.of_domain.domain_name.should == :Boolean
    decoded.domain_generator.class.should == SByC::R::DomainGenerator::Array
  end
  
  [nil, '', "10lqsh", 0.0, -1.0].each{|bad|
    it "should reject #{bad.inspect}" do
      lambda{ R::Domain.parse_literal(bad) }.should raise_error(SByC::TypeError)
      lambda{ R::Domain.parse_literal(bad.inspect) }.should raise_error(SByC::TypeError)
    end
  }
  
end
