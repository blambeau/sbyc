require 'sbyc/logic/formula'
require 'sbyc/logic/term'
require 'sbyc/logic/false'
require 'sbyc/logic/true'
require 'sbyc/logic/variable'
require 'sbyc/logic/finite'
require 'sbyc/logic/ordered'
module Logic
  
  # All logic
  TRUE = Logic::True.new
  
  # False logic
  FALSE = Logic::False.new
  
end