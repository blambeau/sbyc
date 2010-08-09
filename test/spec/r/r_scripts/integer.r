# equality
(should (equals? 12, 13),
        (eq false))
(should (equals? 12, 12),
        (eq true))
# plus
(should (plus 12, 13),
        (eq 25))
# minus
(should (minus 25, 13),
        (eq 12))
# times
(should (times 5, 5),
        (eq 25))
