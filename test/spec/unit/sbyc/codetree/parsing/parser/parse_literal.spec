require File.expand_path('../../../../../../spec_helper', __FILE__)
describe "CodeTree::Parsing::Parser#parse_domain_literal" do
  
  [
    [ 'true',  true ],
    [ 'false', false ],
    [ 'Kernel', Kernel ],
    [ 'SByC::CodeTree', SByC::CodeTree ],
    [ '-1.0', -1.0 ],
    [ '+1.0', +1.0 ],
    [ '1.0', 1.0 ],
    [ '0', 0 ],
    [ '10', 10 ],
    [ '12', 12 ],
    [ '/[a-z]/', /[a-z]/ ],
    [ "'hello'", 'hello' ],
    [ '"hello"', 'hello' ],
    [ ':hello', :hello ],
  ].each{|example|
    it "should decode #{example[0].inspect} correctly" do
      p = CodeTree::Parsing::Parser.new(example[0])
      p.parse_literal.should == CodeTree::parse{ example[1] }
    end
  }

end