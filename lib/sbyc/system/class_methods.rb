module SByC
  class System
    module ClassMethods

      # Returns true if _expected_ is an (non necesarilly proper) ancestor class 
      # of _candidate_  
      def is_ancestor_class?(expected, candidate)
        (expected == candidate) or (
          candidate.superclass and 
          is_ancestor_class?(expected, candidate.superclass)
        )
      end
  
    end
    extend ClassMethods
  end # class System
end # module SByC