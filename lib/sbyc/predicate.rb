require 'sbyc/predicate/term'
require 'sbyc/predicate/named_term'
require 'sbyc/predicate/none'
require 'sbyc/predicate/all'
require 'sbyc/predicate/belongs_to'
require 'sbyc/predicate/allbut'
require 'sbyc/predicate/interval'
require 'sbyc/predicate/between'
require 'sbyc/predicate/and'
module Predicate
  
  # All predicate
  ALL = Predicate::All.new
  
  # None predicate
  NONE = Predicate::None.new
  
  def self.and(*terms)
    And.new(*terms)
  end
  
  # Factors a between predicate
  def self.between(name, x, y)
    Predicate::Between.new(name, Interval.natural(x, y))
  end
  
  # Factors a gt predicate
  def self.gt(name, x)
    Predicate::Between.new(name, Interval.gt(x))
  end
  
  # Factors a gte predicate
  def self.gte(name, x)
    Predicate::Between.new(name, Interval.gte(x))
  end
  
  # Factors a gt predicate
  def self.lt(name, x)
    Predicate::Between.new(name, Interval.lt(x))
  end
  
  # Factors a gte predicate
  def self.lte(name, x)
    Predicate::Between.new(name, Interval.lte(x))
  end
  
end