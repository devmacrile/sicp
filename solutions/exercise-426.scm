; 'unless' as a special derived form
(define (unless? exp)
    (tagged-list? exp `unless))

(define (unless->if exp)
    (let ((predicate (cadr exp))
          (usual (caddr exp)))
          (exceptional (cadddr exp)))
      (make-if predicate usual exceptional)))

; Would be useful as a procedure in conjunction 
; with higher order functions like map, etc.
