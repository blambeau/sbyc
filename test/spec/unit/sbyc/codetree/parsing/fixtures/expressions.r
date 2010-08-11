(ite (> x 10) 
     (say 'hello world') 
     (say 'good bye'))

(puts "hello" name)

# hello
(wrap-ruby-domain :Uri, String)

# The following function does something
# this is a multi-line comment
(define-operator :say_hello
                 (signature :name String)
                 (returns String)
  (puts 'hello')
)

(operator {- name:         :domain
             description:  "Uri's domain"
             signature:    {- operand: String -}
             returns:      String -}
  (send (unwrap operand) :domain) 
)
