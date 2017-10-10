; implement and/or as derived-expression special forms
(define (and? exp)
    (tagged-list? exp `and))

(define (make-and seq)
    (list `and seq))

(define (eval-and exp env)
    (let ((first (cadr exp))
          (rest (cddr exp)))
      (if (null? rest)
        (eval first)
        (if (not (eval first))
            #f
            (eval-and (make-and rest))))))

(define (or? exp)
    (tagged-list? exp `or))

(define (make-or seq)
    (list `or seq))

(define (or? exp env)
    (let ((first (cadr exp))
          (rest (cddr exp)))
      (if (null? rest)
        (eval first)
        (if (eval first)
            #t
            (eval-or (make-or rest))))))

(put `and (lambda (exp env) (eval-and exp env)))
(put `or (lambda (exp env) (eval-or exp env)))


; alternatively, as derived expressions
(define (and->if exp)
    (define (expand predicates)
        (if (null? predicates)
            #t
            (let ((first (car predicates))
                  (rest (cdr predicates)))
              (make-if first
                       (expand rest)
                       #f))))
    (expand (cdr exp)))

(define (eval-and exp env)
    (eval (and->if exp) env))

; same type of story for and->or
