; (a)
(and (supervisor (Bitdiddle Ben) ?x)
     (address ?person ?where))

; (b)
(and (salary ?person ?amount)
     (salary (Bitdiddle Ben) ?ben-amount)
     (lisp-value < ?amount ?ben-amount))

; (c)
(and (supervisor ?name ?supervisor)
     (job ?supervisor ?title)
     (not (job supervisor? (computer . ?rest))))
