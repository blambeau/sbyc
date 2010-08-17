SByC::R.operators.define{
  
  operator{|op|
    op.description = %Q{ Sends through ruby }
    op.signature   = s(system::Symbol) + (plus system::Alpha)
    op.argnames    = [:method, :operands]
    op.returns     = system::Alpha
    op.aliases     = [:'ruby-send']
  }
  def ruby_send(method, operands) operands.shift.send(method, *operands) end
  
}