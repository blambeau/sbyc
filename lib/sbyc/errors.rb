module SByC
  class Error < ::StandardError; end
  class AssertionError < ::SByC::Error; end
  class TypeError < ::SByC::Error; end
end