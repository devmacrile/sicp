; (a)
(define (lookup-variable-value var env)
    (define (env-loop env)
        (define (scan vars vals)
            (cond ((null? vars)
                   (env-loop (enclosing-environment env)))
                  ((eq? var (car vars))
                    (if (not (eq? (car vals) `*unassigned*))
                        (car vals)
                        (error "Unassigned variable found" var)))
                  (else (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                (scan (frame-variables frame)
                      (frame-values frame)))))
    (env-loop env))

; (b)
; (lambda <vars>
;   (define u <e1>)
;   (define v <e2>)
;   <e3>)
;
; (lambda (<vars>)
;   (let ((u `*unassigned*)
;         (v `*unassigned*))
;      (set! u <e1>)
;      (set! v <e2>)
;      <e3>))
; 
; Slightly confused why we only take a procedure-body?
; ^Then just making body of the lambda above.
(define (scan-out-defines proc-body)
    (let* ((defines (filter definition? proc-body))
           (rest (filter (lambda (e) (not (definition? e))) proc-body))
           (vars (map definition-variable definitions))
           (vals (map (definition-value definitions))))
      (define (unassigned-binding var)
        (list var `*unassigned*`))
      (define (make-binding var val)
        (list `set! var val))
      (append 
        (list `let
              (map unassigned-binding vars)
              (map make-binding vars vals)
              rest))))

; (c)
; From an efficiency standpoint (as in earlier chapters), makes
; sense in this case to place it in make-procedure (i.e. the body
; will be accessed much more often than the procedure defined).
