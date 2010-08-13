require "enumerator"
module SByC
  module R
    class Operator
      class PairedSignature < Signature
        
        # Creates a signature instance
        def initialize(key_domain, value_domain)
          super([key_domain, value_domain])
        end
        
        # Checks if this signature matches a list of
        # domains
        def domain_matches?(domains, requester = nil)
          return false unless (domains.size % 2 == 0)
          key_declared, value_declared = self.domains
          key_declared   ||= requester
          value_declared ||= requester
          domains.each_slice(2){|key, value|
            return false unless key.has_super_domain?(key_declared) &&
                                value.has_super_domain?(value_declared)
          }
          true
        end

        # Does the signature matches some arguments?
        def arg_matches?(args, requester = nil)
          return false unless (args.size % 2 == 0)
          key_declared, value_declared = self.domains
          key_declared   ||= requester
          value_declared ||= requester
          args.each_slice(2){|key, value|
            return false unless key_declared.is_value?(key) &&
                                value_declared.is_value?(value)
          }
          true
        end
        
        # Makes an operator call on some arguments
        def make_operator_call(callable, args, &block)
          h = {}
          args.each_slice(2){|key, value|
            h[key] = value
          }
          callable.call(h, &block)
        end

      end # class AggregateSignature
    end # class Operator
  end # module R
end # module SByC
