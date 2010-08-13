(should (String "hello"),
        (eq "hello"))

# at
(should (at "hello", 0),
        (eq "h"))
(should (at "hello", 4),
        (eq "o"))
(should ([] "hello", 4),
        (eq "o"))
(should (at "hello", 5),
        (eq ""))
(should ([] "hello", 5),
        (eq ""))

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

# to_s
(should (to_s "hello"),
        (eq "hello"))

# upcase
(should (upcase "hello"),
        (eq "HELLO"))

# center
(should (center "hello", 10),
        (eq "  hello   "))
(should (center "hello", 2),
        (eq "hello"))
        
# concat 
(should (concat "hello", " world"),
        (eq "hello world"))
(should (concat "1", "2", "3", "4"),
        (eq "1234"))
 
# include?       
(should (include? "hello", "ll"),
        (eq true))
(should (include? "hello", "x"),
        (eq false))

# matches?       
(should (matches? "hello", /ll/),
        (eq true))
(should (matches? "hello", /x/),
        (eq false))

# times
(should (times "hello", 3),
        (eq "hellohellohello"))