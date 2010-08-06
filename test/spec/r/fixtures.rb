require File.expand_path('../../spec_helper', __FILE__)
module SByC
  module Fixtures
    module R
      
      BOOLEANS = [true, false]
      FIXNUMS  = [ -(2**(0.size * 8 - 2)), -1, 0, 1, 10, (2**(0.size * 8 - 2) - 1)]
      BIGNUMS  = [ -(2**(0.size * 8 - 2)) - 1, (2**(0.size * 8 - 2)) ]
      INTEGERS = FIXNUMS + BIGNUMS
      STRINGS  = ['', 'hello', "O'Neil", '"What magic, he said"']
      FLOATS   = [ -0.10, 0.0, 0.10 ]
      TIMES    = [ Time.at(0), Time.utc(2010, 8, 5, 12, 15, 00) ]
      DATES    = [ Date.today ]
      SYMBOLS  = [ :var, :something_with_underscores, :'s#', :hello, :"s-b-y-c", :"12" ]
      REGEXPS  = [ /a-z/, /^$/, /\s*/, /[a-z]{15}/ ]
      MODULES  = [ SByC, SByC::Typing, SByC::Typing::R, SByC::Typing::Domain ]
      
    end # module R
  end # module Fixtures
end # module SByC