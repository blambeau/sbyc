code = CodeTree::parse{ x > 10 & y < 20 }   
# => (& (> x, 10), (< y, 20))

# See the evaluation section for details
code.eval{:x => 5, :y => 5}                
# => true

# See the code-generation section for details
code.object_compile('scope', :[])          
# => "scope[:x].>(10) & scope[:y].<(20)"

# CodeTree expressions may be marshaled
Marshal.dump(code)
