(should (plus 12.0, 13.0),
        (eq 25.0))
(should (plus 12, 13.0),
        (eq 25.0))
(should (plus 12.0, 13),
        (eq 25.0))
#
(should (minus 25.0, 13.0),
        (eq 12.0))
(should (minus 25, 13.0),
        (eq 12.0))
(should (minus 25.0, 13),
        (eq 12.0))
#
(should (times 5.0, 5.0),
        (eq 25.0))
(should (times 5, 5.0),
        (eq 25.0))
(should (times 5.0, 5),
        (eq 25.0))
# gt
(should (gt 5.0, 25.0),
        (eq false))
(should (gt 25.0, 5.0),
        (eq true))
