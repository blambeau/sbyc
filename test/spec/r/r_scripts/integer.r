# equality
(should (equals? 12, 13),
        (eq false))
(should (equals? 12, 12),
        (eq true))
# addition
(should (addition 12, 13),
        (eq 25))
(should (addition 1, 2, 3, 4),
        (eq 10))
(should (plus 12, 13),
        (eq 25))
# substraction
(should (substraction 25, 13),
        (eq 12))
(should (minus 25, 13),
        (eq 12))
# multiplication
(should (multiplication 5, 5),
        (eq 25))
(should (multiplication 2, 2, 2, 2),
        (eq 16))
(should (multiply 2, 2, 2, 2),
        (eq 16))
(should (times 2, 2, 2, 2),
        (eq 16))

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
