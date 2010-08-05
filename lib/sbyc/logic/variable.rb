module Logic
  class Variable
    
    # Variable's name
    attr_reader :name
    
    # Variable's domain
    attr_reader :domain
    
    # Creates a variable instance
    def initialize(name, domain)
      @name = name
      @domain = domain
    end
    
    # Converts something to a variable instance
    def self.coerce(var)
      case var
        when Variable 
          var
        when Symbol
          Variable.new(var, nil)
        else
          raise ArgumentError, "Unable to convert #{var} to a Variable"
      end
    end
    
    def ==(other)
      other.kind_of?(Variable) and other.name==name and other.domain==domain
    end
    
    def to_s
      "#{name}"
    end
    
    def inspect
      "Variable(#{name}, #{domain})"
    end
    
  end # class Variable
end # module Logic