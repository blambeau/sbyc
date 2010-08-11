(should (addition 12.0, 13.0),
        (eq 25.0))
#
(should (substraction 25.0, 13.0),
        (eq 12.0))
#
(should (multiplication 5.0, 5.0),
        (eq 25.0))
# gt
(should (gt 5.0, 25.0),
        (eq false))
(should (gt 25.0, 5.0),
        (eq true))
