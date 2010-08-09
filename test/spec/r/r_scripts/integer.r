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

# compare
(should (compare 5, 25),
        (eq -1))
(should (compare 5, 5),
        (eq 0))
(should (compare 25, 5),
        (eq 1))
# gt
(should (gt 5, 25),
        (eq false))
(should (gt 5, 5),
        (eq false))
(should (gt 25, 5),
        (eq true))
# gte
(should (gte 5, 25),
        (eq false))
(should (gte 5, 5),
        (eq true))
(should (gte 25, 5),
        (eq true))
# lt
(should (lt 5, 25),
        (eq true))
(should (lt 5, 5),
        (eq false))
(should (lt 25, 5),
        (eq false))
# lte
(should (lte 5, 25),
        (eq true))
(should (lte 5, 5),
        (eq true))
(should (lte 25, 5),
        (eq false))

