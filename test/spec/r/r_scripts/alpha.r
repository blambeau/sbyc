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
        (eq R::Boolean))
(should (domain-of R::Alpha),
        (eq R::Domain))
(should (domain-of R::Boolean),
        (eq R::Domain))
(should (domain-of R::Domain),
        (eq R::Domain))
(should (domain-of "hello"),
        (eq R::String))
        
# is-a?
(should (is-a? R::Boolean true),
        (eq true))