(define (make-let binding body)
    (list `let (list binding) body))

(define (let*->nested-lets exp)
    (define (nested-lets bindings body)
        (let ((first (car bindings))
              (rest (cdr bindings)))
            (if (null? rest)
                (make-let first body)
                (make-let first (nested-lets rest body)))))
    (let ((bindings (cadr exp))
          (body (caddr exp))
          (nested-lets bindings body))))