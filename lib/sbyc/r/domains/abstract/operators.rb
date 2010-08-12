module SByC
  module R
    module AbstractDomain
      module Operators

        # Finds an operator by signature
        def find_operator_by_signature(name, signature, requester = self)
          # first case: a matching operator exists in domain own operators
          op = self::Operators::find_operator_by_signature(name, signature, requester)
          return op unless op.nil?
        
          # third case: a matching operator exists in a structure
          each_immediate_structure{|struct|
            op = struct.find_operator_by_signature(name, signature, requester)
            return op unless op.nil?
          }
        
          # second case: a matching operator exists in a super domain
          each_immediate_super_domain{|dom|
            op = dom.find_operator_by_signature(name, signature, requester)
            return op unless op.nil?
          }
        
          # nothing found
          nil
        end

        # Finds an operator by arguments
        def find_operator_by_args(name, args, requester = self)
          # first case: a matching operator exists in domain own operators
          op = self::Operators::find_operator_by_args(name, args, requester)
          return op unless op.nil?
        
          # third case: a matching operator exists in a structure
          each_immediate_structure{|struct|
            op = struct.find_operator_by_args(name, args, requester)
            return op unless op.nil?
          }
        
          # second case: a matching operator exists in a super domain
          each_immediate_super_domain{|dom|
            op = dom.find_operator_by_args(name, args, requester)
            return op unless op.nil?
          }
        
          # nothing found
          nil
        end
        
      end # module Operators
    end # module AbstractDomain
  end # module R
end # module SByC