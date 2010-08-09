(should (equals? true, true),
        (eq true))
(should (equals? true, false),
        (eq false))
(should (equals? true, ""),
        (eq false))
