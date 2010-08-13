module SByC
  module R
    class DomainGenerator
      class Builder
        
        # Creates a builder instance
        def initialize(system, &block)
          @system = system
          @builtin = DomainGenerator::Builtin.new
          @array   = DomainGenerator::Array.new
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
        
      end # class Builder
    end # class DomainGenerator
  end # module R
end # module SByC