SByC::R::String::Operators.define{
  
  operator{|op|
    op.description = %Q{ Returns the substring at a given position }
    op.signature   = seq(system::String, system::Integer)
    op.argnames    = [:operand, :at]
    op.returns     = system::String
    op.aliases     = [:at, :[]]
  }
  def at(operand, at) operand[at, 1] || ""; end
  
  operator{|op|
    op.description = %Q{ Capitalizes a string }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:capitalize]
  }
  def capitalize(operand) operand.capitalize; end

  operator{|op|
    op.description = %Q{ Concatenates strings }
    op.signature   = star(system::String)
    op.argnames    = [:operands]
    op.returns     = system::String
    op.aliases     = [:concat, :+]
  }
  def concat(operands) operands.inject(""){|memo,op| memo + op}; end

  operator{|op|
    op.description = %Q{ Puts a string in downcase }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:downcase]
  }
  def downcase(operand) operand.downcase; end

  operator{|op|
    op.description = %Q{ Checks if a string is empty? }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::Boolean
    op.aliases     = [:empty?]
  }
  def empty?(operand) operand.empty?; end

  operator{|op|
    op.description = %Q{ Returns length of a string }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::Integer
    op.aliases     = [:length]
  }
  def length(operand) operand.length; end

  operator{|op|
    op.description = %Q{ Checks if the string matches a given regular expression }
    op.signature   = seq(system::String, system::Regexp)
    op.argnames    = [:operand, :regexp]
    op.returns     = system::Boolean
    op.aliases     = [:matches?, :===]
  }
  def matches?(operand, regexp) regexp === operand; end

  operator{|op|
    op.description = %Q{ Reverses a string }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:reverse]
  }
  def reverse(operand) operand.reverse; end

  operator{|op|
    op.description = %Q{ Strips the end of a string }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:rstrip]
  }
  def rstrip(operand) operand.rstrip; end

  operator{|op|
    op.description = %Q{ Strips a string }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:strip]
  }
  def strip(operand) operand.strip; end

  operator{|op|
    op.description = %Q{ Returns the string }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:to_s]
  }
  def to_seq(operand) operand.to_s; end

  operator{|op|
    op.description = %Q{ Puts a string in upcase }
    op.signature   = seq(system::String)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:upcase]
  }
  def upcase(operand) operand.upcase; end

  operator{|op|
    op.description = %Q{ Centers a string }
    op.signature   = seq(system::String, system::Integer)
    op.argnames    = [:operand, :length]
    op.returns     = system::String
    op.aliases     = [:center]
  }
  def center(operand, length) operand.center(length); end

  operator{|op|
    op.description = %Q{ Centers a string }
    op.signature   = seq(system::String, system::String)
    op.argnames    = [:operand, :substr]
    op.returns     = system::Boolean
    op.aliases     = [:include?]
  }
  def include?(operand, substr) operand.include?(substr); end
  
  operator{|op|
    op.description = %Q{ Centers a string }
    op.signature   = seq(system::String, system::Integer)
    op.argnames    = [:operand, :nb]
    op.returns     = system::String
    op.aliases     = [:times, :*]
  }
  def timeseq(operand, nb) operand * nb; end

}
