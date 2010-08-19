# equals?
(should (equals? true, true),
        (eq true))
(should (equals? true, false),
        (eq false))
(should (equals? true, ""),
        (eq false))

# equal
(should (equal true, false),
        (eq false))
(should (equal true, true, true),
        (eq true))
(should (equal true, false, true),
        (eq false))

# domain
(should (domain-of true),
        (eq Boolean))
(should (domain-of Alpha),
        (eq Domain))
(should (domain-of Boolean),
        (eq Domain))
(should (domain-of Domain),
        (eq Domain))
(should (domain-of "hello"),
        (eq String))
        
# is-a?
(should (is-a? Domain Integer)
        (eq true))
(should (is-a? Boolean true),
        (eq true))