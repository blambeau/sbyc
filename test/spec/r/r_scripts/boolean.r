(should (Boolean true),
        (eq true))
(should (Boolean false),
        (eq false))
# equality
(should (equals? true, true),
        (eq true))
(should (equals? true, false),
        (eq false))
# complement
(should (complement true),
        (eq false))
(should (complement false),
        (eq true))
# conjunction
(should (conjunction true, true),
        (eq true))
(should (conjunction true, false),
        (eq false))
# disjunction
(should (disjunction true, true),
        (eq true))
(should (disjunction true, false),
        (eq true))
(should (disjunction false, false),
        (eq false))


        