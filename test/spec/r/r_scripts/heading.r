(should (domain-of (Heading :name String, :age Integer))
        (eq Heading))
(should (domain-of :name, (Heading :name String, :age Integer)),
        (eq String))