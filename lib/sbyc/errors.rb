module SByC
  class Error < ::StandardError; end
  class TypeError < ::SByC::Error; end
  class TypeImplementationError < ::SByC::Error; end
end