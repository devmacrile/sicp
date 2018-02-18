(rule (append-to-form () ?y ?y))

(rule (append-to-form (?u . ?v) ?y (?u . ?z))
      (append-to-form ?v ?y ?z))

(rule (reverse-list () ()))
(rule (reverse-list (?u . ?v) ?y)
      (and (reverse-list ?v ?rev-rest)
           (append-to-form ?rev-rest ?u ?y))

; It will be the order-of-evaluation of the and clauses
; that will determine which query will terminate and which will
; not.  With this form, if we have a query in which ?v is unbound 
; like (reverse ?x (1 2 3)), then this will in turn call reverse-list
; on two unbound three unbound variables which will have an infinite 
; number of answers.  Calling (reverse (1 2 3) ?x), however, will return.
;
; If the append-to-form were evaluated first, then the (reverse ?x (1 2 3))
; query would create the pattern (append-to-form ?rev-rest ?u (1 2 3)) which
; will evaluate.  The pattern (append-to-form ?rev-rest ?1 ?y) would have an
; infinite number of solutions however (viz. lists ending in one).
