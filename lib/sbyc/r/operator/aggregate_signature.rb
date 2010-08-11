module SByC
  module R
    class Operator
      class AggregateSignature < Signature
        
        # Creates a signature instance
        def initialize(domain)
          super([domain])
        end
        
        # Checks if this signature matches a list of
        # domains
        def domain_matches?(domains, requester = nil)
          declared = self.domains.first || requester
          domains.all?{|dom| (dom == declared) || (dom.has_super_domain?(declared))}
        end

        # Does the signature matches some arguments?
        def arg_matches?(args, requester = nil)
          declared = self.domains.first || requester
          args.all?{|arg| declared.is_value?(arg)}
        end
        
        # Makes an operator call on some arguments
        def make_operator_call(callable, args, &block)
          callable.call(args, &block)
        end

      end # class AggregateSignature
    end # class Operator
  end # module R
end # module SByC
