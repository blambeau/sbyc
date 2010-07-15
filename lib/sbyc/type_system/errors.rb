module TypeSystem
  class Error < StandardError; end
  class InvalidValueLiteralError < Error; end
  class NoSuchLiteralError < Error; end
end # module TypeSystem