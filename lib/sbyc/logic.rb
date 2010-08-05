require 'sbyc/logic/term'
require 'sbyc/logic/named_term'
require 'sbyc/logic/none'
require 'sbyc/logic/all'
require 'sbyc/logic/belongs_to'
require 'sbyc/logic/allbut'
require 'sbyc/logic/interval'
require 'sbyc/logic/between'
require 'sbyc/logic/and'
module Logic
  
  # All logic
  ALL = Logic::All.new
  
  # None logic
  NONE = Logic::None.new
  
  def self.and(*terms)
    And.new(*terms)
  end
  
  # Factors a between logic
  def self.between(name, x, y)
    Logic::Between.new(name, Interval.natural(x, y))
  end
  
  # Factors a gt logic
  def self.gt(name, x)
    Logic::Between.new(name, Interval.gt(x))
  end
  
  # Factors a gte logic
  def self.gte(name, x)
    Logic::Between.new(name, Interval.gte(x))
  end
  
  # Factors a gt logic
  def self.lt(name, x)
    Logic::Between.new(name, Interval.lt(x))
  end
  
  # Factors a gte logic
  def self.lte(name, x)
    Logic::Between.new(name, Interval.lte(x))
  end
  
end