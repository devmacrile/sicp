; Changes necessary to allow:
; (define (f z (b lazy) c (d lazy-memo))
;   ...)


; from eval's cond, keep it exactly the same as the fully lazy case 
; (i.e. a force on a forced object is fine, a la 4.30.c)
((application? exp)
    (apply (actual-value (operator exp) env)
           (operands exp)
           env))

(define (apply procedure arguments env)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure 
            procedure 
            (list-of-arg-values arguments env)))
          ((compound-procedure? procedure)
            (eval-sequence
                (procedure-body procedure)
                (extend-environment
                    (procedure-parameters procedure)
                    (list-of-mixed-args arguments env)  ; changed
                    (procedure-environment procedure))))
          (else
            (error "Unknown procedure type -- APPLY" procedure))))


(define (actual-value exp env)
    (force-it (eval exp env)))


; meat of the change is here, determining whether
; the operand is one of lazy, lazy-memo, or neither
; and dispatching to a form of delay or actual value
; based on this tag
(define (list-of-mixed-args exps env)
    (if (no-operands? exps)
        `()
        (let ((op (first-operand exps)))
            (cond ((lazy? op)
                    (cons (delay-it (lazy-parameter op) env)
                          (list-of-mixed-args (rest-operands exps) env)))
                  ((lazy-memo? op)  
                    (cons (delay-it-memoized (lazy-parameter op) env)
                          (list-of-mixed-args (rest-operands exps) env)))
                  (else
                    (cons (actual-value op env)
                          (list-of-mixed-args (rest-operands exps) env)))))))

(define (lazy? operand)
    (= (lazy-tag operand) `lazy))

(define (lazy-memo? operand)
    (= (lazy-tag operand) `lazy-memo))

(define (lazy-tag operand)
    (cadr operand))

(define (lazy-parameter operand)
    (car operand))

(define (delay-it exp env)
    (list `thunk exp env))

(define (delay-it-memoized exp env)
    (list `memo-thunk exp env))

(define (memo-thunk? obj)
    (tagged-list? obj `memo-thunk))

(define (thunk? obj)
    (tagged-list? obj `thunk))

(define (thunk-exp thunk)
    (cadr thunk))

(define (thunk-env thunk)
    (caddr thunk))

(define (evaluated-thunk? obj)
    (tagged-list? obj `evaluated-thunk))

(define (thunk-value evaluated-thunk)
    (cadr evaluated-thunk))

(define (force-it obj)
    (cond ((memo-thunk? obj)
            (let ((result (actual-value
                            (thunk-exp obj)
                            (thunk-env obj))))
              (set-car! obj `evaluated-thunk)
              (set-car! (cdr obj) result)  ; cache result
              (set-cdr! (cdr obj) `())  ; dump environment to save space
              result))
          ((evaluated-thunk? obj)
            (thunk-value obj))
          ((thunk? obj)
            (actual-value (thunk-exp obj) (thunk-env obj)))
          (else obj)))
