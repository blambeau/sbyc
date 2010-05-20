code = CodeTree:parse{ x > 10 & y < 20 }   # (& (> x, 10), (< y, 20))
code.eval{:x => 5, :y => 5}                # true
code.ruby_code('scope', :[])               # "scope[:x].>(10) & scope[:y].<(20)"
Marshall.dump(code)                        # this works perfectly!
