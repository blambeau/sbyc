# Hash-style
CodeTree::parse{|t| (t[:x] > 5) & (t[:y] <= 10) }  # => (& (> x, 5), (<= y, 10))

# Object-style
CodeTree::parse{|t| (t.x > 5) & (t.y <= 10)     }  # => (& (> x, 5), (<= y, 10))

# Context-style
CodeTree::parse{ (x > 5) & (y <= 10)            }  # => (& (> x, 5), (<= y, 10))

# Functional-style
CodeTree::parse{ (both (gt x, 5), (lte y, 10))  }  # => (both (gt x, 5), (lte y, 10))
