(rule (last-pair (?x) (?x)))

(rule (last-pair (?u . ?v) (?x))
      (last-pair ?v (?x)))



(last-pair (3) ?x)
(last-pair (1 2 3) ?x)
(last-pair (2 ?x) (3))

; Does the following work?
; Should "work", but there are an infinite 
; number of solutions (i.e. lists ending with 3).
(last-pair ?x (3))
