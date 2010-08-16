SByC::R::Alpha::Operators.define{
  
  operator{|op|
    op.description = %Q{ Value equality }
    op.signature   = seq(system::Alpha, system::Alpha)
    op.argnames    = [:left, :right]
    op.returns     = system::Boolean
    op.aliases     = [:equals?, :==]
  }
  def equals?(left, right) left == right; end
  
  operator{|op|
    op.description = %Q{ Value equality (aggregate) }
    op.signature   = star(system::Alpha)
    op.argnames    = [:operands]
    op.returns     = system::Boolean
    op.aliases     = [:equal]
  }
  def equal(operands) 
    if operands.empty?
      true
    else
      first = operands.shift
      operands.all?{|op| equals?(first, op)}
    end
  end
  
  operator{|op|
    op.description = %Q{ Returns domain of a value }
    op.signature   = seq(system::Alpha)
    op.argnames    = [:operand]
    op.returns     = system::Domain
    op.aliases     = [:'domain-of']
  }
  def domain_of(operand) system::Alpha::domain_of(operand); end
  
  operator{|op|
    op.description = %Q{ Checks if a value belongs to a domain }
    op.signature   = seq(system::Alpha, system::Domain)
    op.argnames    = [:operand, :domain]
    op.returns     = system::Boolean
    op.aliases     = [:'is-a?']
  }
  def is_a?(operand, domain) domain.is_value?(operand); end
  
  operator{|op|
    op.description = %Q{ Coerces a value to a given domain }
    op.signature   = seq(system::Alpha, system::Domain)
    op.argnames    = [:operand, :domain]
    op.returns     = system::Alpha
    op.aliases     = [:coerce]
  }
  def coerce(operand, domain); domain.coerce(operand); end

  operator{|op|
    op.description = %Q{ Returns a literal for a given value }
    op.signature   = seq(system::Alpha)
    op.argnames    = [:operand]
    op.returns     = system::String
    op.aliases     = [:to_literal]
  }
  def to_literal(operand) domain_of(operand).to_literal(operand) end

}