require 'sbyc/formulae/term'
require 'sbyc/formulae/named_term'
require 'sbyc/formulae/none'
require 'sbyc/formulae/all'
require 'sbyc/formulae/belongs_to'
require 'sbyc/formulae/allbut'
require 'sbyc/formulae/interval'
require 'sbyc/formulae/between'
require 'sbyc/formulae/and'
module Formulae
  
  # All formulae
  ALL = Formulae::All.new
  
  # None formulae
  NONE = Formulae::None.new
  
  def self.and(*terms)
    And.new(*terms)
  end
  
  # Factors a between formulae
  def self.between(name, x, y)
    Formulae::Between.new(name, Interval.natural(x, y))
  end
  
  # Factors a gt formulae
  def self.gt(name, x)
    Formulae::Between.new(name, Interval.gt(x))
  end
  
  # Factors a gte formulae
  def self.gte(name, x)
    Formulae::Between.new(name, Interval.gte(x))
  end
  
  # Factors a gt formulae
  def self.lt(name, x)
    Formulae::Between.new(name, Interval.lt(x))
  end
  
  # Factors a gte formulae
  def self.lte(name, x)
    Formulae::Between.new(name, Interval.lte(x))
  end
  
end