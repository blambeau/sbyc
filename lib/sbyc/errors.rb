module SByC
  class Error < ::StandardError; end
  class TypeSystemError < ::SByC::Error; end
  class TypeError < ::SByC::Error; end
  class TypeImplementationError < ::SByC::Error; end
end