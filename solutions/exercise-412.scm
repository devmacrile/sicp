(define (lookup-variable-value var env)
    (env-loop env (scan `lookup)))

(define (set-variable-value! var env)
    (env-loop env (scan `set)))

(define (define-variable! var val env)
    (let ((frame (first-frame env)))
        (scan frame `set)))

(define (env-loop env proc)
    (if (eq? env the-empty-environment)
        (error "Unbound variable")
        (let ((frame (first-frame env)))
            (proc frame))))

(define (scan action)
    (lambda (frame)
        (let ((vars (frame-variables frame))
              (vals (frame-values frame)))
            (cond ((null? vars)
                     (env-loop (enclosing-environment env)))
                  ((eq? var (car vars))
                    (cond ((eq? action `lookup)
                             (car vals))
                          ((eq? action `set)
                             (set-car! vals val))
                          (else (error "Unknown action -- SCAN" action))))
                  (else (scan (cdr vars) (cdr vals) action))))))
