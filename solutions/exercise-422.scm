(define (analyze-let exp)
    (analyze (let->combination exp))

; from 4.06
(define (let->combination exp)
    (let ((vars (map car (cadr exp)))
          (exps (map cadr (cadr exp)))
          (body (caddr exp)))
      (cons (make-lambda vars body) exps)))