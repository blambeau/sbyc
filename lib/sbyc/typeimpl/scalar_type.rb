require 'sbyc/typeimpl/scalar_type/class_methods'
require 'sbyc/typeimpl/scalar_type/instance_methods'
require 'sbyc/typeimpl/scalar_type/representation'
require 'sbyc/typeimpl/scalar_type/dsl'
module SByC
  class ScalarType
    extend ::SByC::Type
    extend ::SByC::ConstraintAble
    extend ::SByC::ScalarType::ClassMethods
    include ::SByC::ScalarType::InstanceMethods
  end
end