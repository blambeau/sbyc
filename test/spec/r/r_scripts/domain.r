# domain-of
(should (domain-of true)
        (eq Boolean))
(should (domain-of 12)
        (eq Integer))
        
# is-a?
(should (is-a? Boolean true)
        (eq true))
(should (is-a? Boolean "true")
        (eq false))
        
# is-sub-domain-of?
(should (is-sub-domain-of? Alpha Alpha)
        (eq true))
(should (is-sub-domain-of? Boolean Alpha)
        (eq true))
(should (is-sub-domain-of? Alpha Boolean)
        (eq false))
(should (is-sub-domain-of? Integer Numeric)
        (eq true))
(should (is-sub-domain-of? Integer Alpha)
        (eq true))
(should (is-sub-domain-of? Integer Float)
        (eq false))

# is-proper-sub-domain-of?
(should (is-proper-sub-domain-of? Boolean Alpha)
        (eq true))
(should (is-proper-sub-domain-of? Alpha Alpha)
        (eq false))
        
# is-super-domain-of?
(should (is-super-domain-of? Alpha Alpha)
        (eq true))
(should (is-super-domain-of? Alpha Boolean)
        (eq true))
(should (is-super-domain-of? Boolean Alpha)
        (eq false))
(should (is-super-domain-of? Numeric Integer)
        (eq true))
(should (is-super-domain-of? Alpha Integer)
        (eq true))
(should (is-super-domain-of? Float Integer)
        (eq false))

# is-proper-super-domain-of?
(should (is-proper-super-domain-of? Alpha Boolean)
        (eq true))
(should (is-proper-super-domain-of? Alpha Alpha)
        (eq false))
        
