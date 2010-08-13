(should (domain-of (generate-domain Array String))
        (eq Domain))
(should (name-of (generate-domain Array String)) 
        (eq :"Array<String>"))
