SByC::R::Alpha::Operators.define{
  
  operator{|op|
    op.description = %Q{ Value equality }
    op.signature   = [SByC::R::Alpha, SByC::R::Alpha]
    op.argnames    = [:left, :right]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:equals?, :==]
  }
  def equals?(left, right) left == right; end
  
  operator{|op|
    op.description = %Q{ Value equality (aggregate) }
    op.signature   = SByC::R::aggregate_signature(SByC::R::Alpha)
    op.argnames    = [:operands]
    op.returns     = SByC::R::Boolean
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
    op.signature   = [SByC::R::Alpha]
    op.argnames    = [:operand]
    op.returns     = SByC::R::Domain
    op.aliases     = [:'domain-of']
  }
  def domain_of(operand) SByC::R::Alpha::domain_of(operand); end
  
  operator{|op|
    op.description = %Q{ Checks if a value belongs to a domain }
    op.signature   = [SByC::R::Alpha, SByC::R::Domain]
    op.argnames    = [:operand, :domain]
    op.returns     = SByC::R::Boolean
    op.aliases     = [:domain?]
  }
  def domain?(operand, domain) domain.is_value?(operand); end
  
  operator{|op|
    op.description = %Q{ Coerces a value to a given domain }
    op.signature   = [SByC::R::Alpha, SByC::R::Domain]
    op.argnames    = [:operand, :domain]
    op.returns     = lambda{|op, heading, args, requester| 
                       args.nil? ? SByC::R::Alpha : args[1]
                     }
    op.aliases     = [:coerce]
  }
  def coerce(operand, domain); domain.coerce(operand); end

  operator{|op|
    op.description = %Q{ Returns a literal for a given value }
    op.signature   = [SByC::R::Alpha]
    op.argnames    = [:operand]
    op.returns     = SByC::R::String
    op.aliases     = [:to_literal]
  }
  def to_literal(operand) domain_of(operand).to_literal(operand) end

}