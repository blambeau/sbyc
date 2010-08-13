class SByC::R::DomainGenerator::Builtin
  module AlphaDomain
    include SByC::R::DomainGenerator::Tools::UnionDomain

    # Returns the domain of a value
    def domain_of(value)
      if value.respond_to?(:sbyc_domain)
        value.sbyc_domain
      else
        begin
          R::Domain::coerce(value.class)
        rescue SByC::TypeError
          raise SByC::TypeError, "Unexpected ruby class #{value.class}"
        end
      end
    end
    
  end # module AlphaDomain
end # class SByC::R::DomainGenerator::Builtin