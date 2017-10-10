; We'll implement a for loop as a derived expression

; (for (<var> <start> <increment> <end>) 
;       <body>)

;(put `for (lambda (exp env) (eval-for exp env)))

(define (for? exp env)
    (tagged-list? exp `for))
(define (for-params exp)
    (cadr exp))
(define (for-var exp)
    (car (for-params exp)))
(define (for-start exp)
    (cadr (for-params exp)))
(define (for-increment exp)
    (caddr (for-params exp)))
(define (for-end exp)
    (cadddr (for-params exp)))
(define (for-body exp)
    (caddddr exp))
(define (make-for variable start increment end body)
    (list `for (list variable start increment end) body))

(define (for->combination exp)
    (let* ((var (for-var exp))
           (start (for-start exp))
           (inc (for-increment exp))
           (end (for-end exp))
           (body (for-body exp)))
      (sequence->exp
        (list
            (list `define
                (list `for-iter var end inc)
                (make-if (var < end)
                  (make-begin 
                    (list body
                          (list `for-iter (+ var 1) end inc)))
                  `()))
            (list `for-iter start end inc)))))

(define (eval-for exp env)
    (eval (for->combination exp) env))
