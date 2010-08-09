# equals?
(should (equals? "hello", "hello"),
        (eq true))
(should (equals? "HELLO", "hello"),
        (eq false))

# capitalize
(should (capitalize "hello"),
        (eq "Hello"))
(should (downcase "HELLO"),
        (eq "hello"))

# empty?
(should (empty? "HELLO"),
        (eq false))
(should (empty? ""),
        (eq true))

# length
(should (length ""),
        (eq 0))
(should (length "hello"),
        (eq 5))

# reverse
(should (reverse ""),
        (eq ""))
(should (reverse "hello"),
        (eq "olleh"))

# rstrip
(should (rstrip "  hello  "),
        (eq "  hello"))

# strip
(should (strip "  hello  "),
        (eq "hello"))

# to_i
(should (to_i "123"),
        (eq 123))

# to_f
(should (to_f "123"),
        (eq 123.0))
(should (to_f "123.5"),
        (eq 123.5))

# to_s
(should (to_s "hello"),
        (eq "hello"))

# upcase
(should (upcase "hello"),
        (eq "HELLO"))

# at
(pending \
  (should (at "hello", 0),
          (eq "h")),
  (should (at "hello", 4),
          (eq "o"))
)

# center
(should (center "hello", 10),
        (eq "  hello   "))
        
# concat 
(should (concat "hello", " world"),
        (eq "hello world"))
 
# include?       
(should (include? "hello", "ll"),
        (eq true))
(should (include? "hello", "x"),
        (eq false))

# matches?       
(pending \
  (should (matches? "hello", /ll/),
          (eq true))
)

# times
(should (times "hello", 3),
        (eq "hellohellohello"))