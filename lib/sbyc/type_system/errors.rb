module SByC
  module TypeSystem
    class Error < StandardError; end
    class InvalidValueLiteralError < Error; end
    class NoSuchLiteralError < Error; end
    class CoercionError < Error; end
  end # module TypeSystem
end # module SByC