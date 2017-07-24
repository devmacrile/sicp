; Keep the list of keys maintained in a binary tree s.t. all the
; keys on the left branch are <= (i.e. alphabetically) the head key,
; and all on the right are > the head key.
; Then lookup involves comparing to the head key:
;   if equal => return object associatied with that key
;   based on comparison, recurse left (car) or right (cdr)
; It's basically identical to 2.66 as the keys form a set (with some
; additional data, of course).