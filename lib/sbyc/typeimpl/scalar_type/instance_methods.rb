module SByC
  class ScalarType
    module InstanceMethods 
      
      # Creates a value
      def initialize(rep, physical_value)
        instance_variable_set("@__#{rep.name}".to_sym, physical_value)
      end
      
      # Builds a representation
      def __build_representation(requested)
        ivar = instance_variable_get("@__#{requested.name}")
        return ivar unless ivar.nil?
        self.class.__possible_representations.each do |rep|
          next if rep == requested
          next if (physrep = instance_variable_get("@__#{rep.name}")).nil?
          next unless rep.has_converter?(requested)
          return rep.convert(physrep, requested)
        end
        raise "Unable to create representation #{requested}"
      end
      
      # Checks equality with another value
      def ==(other)
        return false unless other.class == self.class
        main_rep = "__#{self.class.__main_representation.name}"
        my, his = self.send(main_rep), other.send(main_rep)
        my == his
      end
      
      # Returns a string representation
      def to_s
        mainr = self.class.__main_representation
        physrep = self.__build_representation(mainr)
        buffer = "#{self.class}::#{mainr.name}("
        buffer << mainr.heading.attribute_names.inject(""){|memo,name|
          memo << ", " unless memo.empty?
          memo << ":#{name} => #{physrep.send(name)}"
        }
        buffer << ")"
        buffer
      end
      
    end # module InstanceMethods
  end # class ScalarType
end # module SByC
