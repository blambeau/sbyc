require 'sbyc/predicate/term'
require 'sbyc/predicate/named_term'
require 'sbyc/predicate/none'
require 'sbyc/predicate/all'
require 'sbyc/predicate/belongs_to'
require 'sbyc/predicate/allbut'
require 'sbyc/predicate/interval'
require 'sbyc/predicate/between'
module Predicate
  
  ALL = Predicate::All.new
  
  NONE = Predicate::None.new
  
end