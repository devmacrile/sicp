; adapt let->combination to allow for "named let"
(define (let? exp)
    (tagged-list? exp `let))

(define (named-let? exp)
    (and (let? exp) (variable? (car exp))))

(define (let->combination exp)
  (if (named-let? exp)
    (let* ((vars (map car (cadr exp)))
           (values (map cadr (cadr exp)))
           (body (cdddr exp))
           (proc-name (car exp)))
      (sequence->exp
        (list 
          (list
            `define
            (cons proc-name vars)
            body)
          (cons (proc-name values)))))
    (let ((vars (map (car (cadr exp)))
          (values (map cadr (cadr exp)))
          (body (cddr exp))))
      (cons (make-lambda vars body) values))))
