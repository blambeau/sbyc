module SByC
  module R
    class DomainGenerator
      class Builder
        
        # Creates a builder instance
        def initialize(system, &block)
          @system = system
          @builtin = DomainGenerator::Builtin.new
          @array   = DomainGenerator::Array.new
          @scalar  = DomainGenerator::Scalar.new
          run(&block) if block
        end
        
        # Runs a block
        def run(&block)
          @stack = []
          instance_eval(&block)
        end
        
        def generate(builder, name, args)
          # Generate the domain
          domain = builder.generate(name, args)
          @system.domain_created(name, domain)
          
          # Install it on the last creates domain
          unless @stack.empty?
            @stack.last.refine(domain)
          end
          
          if block_given?
            @stack.push(domain)
            yield 
            @stack.pop
          end
          domain
        end
        
        def Builtin(name, *args, &block)
          generate(@builtin, name, args, &block)
        end
        
        def ArrayOf(subdomain_name)
          subdomain = @system.const_get(subdomain_name)
          name = (subdomain_name == :Alpha) ? :Array : :"Array<#{subdomain_name}>"
          generate(@array, name, subdomain)
        end
        
        def Scalar(name, heading)
          generate(@scalar, name, heading)
        end
        
      end # class Builder
    end # class DomainGenerator
  end # module R
end # module SByC