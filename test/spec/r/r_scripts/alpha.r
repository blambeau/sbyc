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
(should (domain true),
        (eq R::Boolean))
(should (domain R::Alpha),
        (eq R::Domain))
(should (domain R::Boolean),
        (eq R::Domain))
(should (domain R::Domain),
        (eq R::Domain))
(should (domain "hello"),
        (eq R::String))
        
# domain?
(should (domain? true, R::Boolean),
        (eq true))