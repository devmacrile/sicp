; let expressions are derived expressions since
;   (let ((<var1> <exp1>) ... (<varn> <expn>))
;     <body>)
; is equivalent to
;   ((lambda (<var1> ... <varn>)
;      <body>)
;     <exp1>
;      ...
;     <expn>)

(define (let? exp)
    (tagged-list? exp `let))
; in eval, use ^ in new cond clause

(define (let->combination exp)
    (let ((vars (map car (cadr exp)))
          (exps (map cadr (cadr exp)))
          (body (caddr exp)))
      (cons (make-lambda vars body) exps)))