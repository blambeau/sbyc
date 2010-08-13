SByC::R::String::Operators.define{
  
  operator{|op|
    op.description = %Q{ Returns the substring at a given position }
    op.signature   = [SByC::R::String, SByC::R::Integer]
    op.argnames    = [:operand, :at]
    op.returns     = SByC::R::String
    op.aliases     = [:at, :[]]
  }
  def at(operand, at) operand[at, 1] || ""; end
  
  operator{|op|
    op.description = %Q{ Capitalizes a string }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:capitalize]
  }
  def capitalize(operand) operand.capitalize; end

  operator{|op|
    op.description = %Q{ Concatenates strings }
    op.signature   = SByC::R::aggregate_signature(SByC::R::String)
    op.argnames    = [:operands]
    op.returns     = SByC::R::String
    op.aliases     = [:concat, :+]
  }
  def concat(operands) operands.inject(""){|memo,op| memo + op}; end

  operator{|op|
    op.description = %Q{ Puts a string in downcase }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:downcase]
  }
  def downcase(operand) operand.downcase; end

  operator{|op|
    op.description = %Q{ Checks if a string is empty? }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:empty?]
  }
  def empty?(operand) operand.empty?; end

  operator{|op|
    op.description = %Q{ Returns length of a string }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::Integer
    op.aliases     = [:length]
  }
  def length(operand) operand.length; end

  operator{|op|
    op.description = %Q{ Checks if the string matches a given regular expression }
    op.signature   = [SByC::R::String, SByC::R::Regexp]
    op.argnames    = [:operand, :regexp]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:matches?, :===]
  }
  def matches?(operand, regexp) regexp === operand; end

  operator{|op|
    op.description = %Q{ Reverses a string }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:reverse]
  }
  def reverse(operand) operand.reverse; end

  operator{|op|
    op.description = %Q{ Strips the end of a string }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:rstrip]
  }
  def rstrip(operand) operand.rstrip; end

  operator{|op|
    op.description = %Q{ Strips a string }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:strip]
  }
  def strip(operand) operand.strip; end

  operator{|op|
    op.description = %Q{ Returns the string }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:to_s]
  }
  def to_s(operand) operand.to_s; end

  operator{|op|
    op.description = %Q{ Puts a string in upcase }
    op.signature   = [SByC::R::String]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:upcase]
  }
  def upcase(operand) operand.upcase; end

  operator{|op|
    op.description = %Q{ Centers a string }
    op.signature   = [SByC::R::String, SByC::R::Integer]
    op.argnames    = [:operand, :length]
    op.returns     = SByC::R::String
    op.aliases     = [:center]
  }
  def center(operand, length) operand.center(length); end

  operator{|op|
    op.description = %Q{ Centers a string }
    op.signature   = [SByC::R::String, SByC::R::String]
    op.argnames    = [:operand, :substr]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:include?]
  }
  def include?(operand, substr) operand.include?(substr); end
  
  operator{|op|
    op.description = %Q{ Centers a string }
    op.signature   = [SByC::R::String, SByC::R::Integer]
    op.argnames    = [:operand, :nb]
    op.returns     = SByC::R::String
    op.aliases     = [:times, :*]
  }
  def times(operand, nb) operand * nb; end

}
