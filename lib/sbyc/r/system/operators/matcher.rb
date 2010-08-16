SByC::R.operators.define{
  
  operator{|op|
    op.description = %Q{ Many times matcher }
    op.signature   = s(system::Matcher)
    op.argnames    = [:operand]
    op.returns     = system::Matcher
    op.aliases     = [:+]
  }
  def plus_matcher(operand) SByC::R::Operator::PlusMatcher.new(operand); end
  
  operator{|op|
    op.description = %Q{ Many times or zero matcher }
    op.signature   = s(system::Matcher)
    op.argnames    = [:operand]
    op.returns     = system::Matcher
    op.aliases     = [:*]
  }
  def star_matcher(operand) SByC::R::Operator::StarMatcher.new(operand); end
  
  operator{|op|
    op.description = %Q{ Checks if the matcher matches some arguments }
    op.signature   = s(system::Matcher, system::Array)
    op.argnames    = [:operand, :args]
    op.returns     = system::Matcher
    op.aliases     = [:matches?, :===]
  }
  def matches?(operand, args) operand.args_matches?(args) end
  
}