module SByC
  class ScalarType
    module ClassMethods
      
      # Deleated to the main representation
      def [](*args)
        __main_representation[*args]
      end
      
      # Returns possible representations
      def __possible_representations
        @__possible_representations ||= []
      end
      
      # Returns the main representation
      def __main_representation
        __possible_representations[0]
      end
      
      # Adds a representation
      def __add_possible_representation(name, heading)
        raise ArgumentError, "Symbol expected for name, #{name.inspect} received" unless Symbol===name
        raise ArgumentError, "Heading expected for heading, #{heading.inspect} received" unless ::SByC::Heading===heading
        rep = Representation.new(self, name, heading)
        __possible_representations << rep
        const_set(name, rep)
        instance_eval <<-EOF
          def #{name}(*args)
            const_get(:#{name})[*args]
          end
        EOF
        heading.each_pair do |attr, type|
          module_eval <<-EOF
            def __#{name}
              @__#{name} ||= __build_representation(#{name})
            end
            def #{attr}
              __#{name}.#{attr}
            end
          EOF
        end
      end
      
      # Adds a conversion
      def __add_conversion(from, to, &block)
        raise ArgumentError, "Symbol expected for from, #{from} received" unless Symbol===from
        raise ArgumentError, "Symbol expected for to, #{to} received" unless Symbol===to
        raise ArgumentError, "Block expected for conversion" if block.nil?
        const_get(from).add_converter(const_get(to), block)
      end
      
    end # module ClassMethods
  end # class ScalarType
end # module SByC