; evaluation order (on operands) is inherited from the underlying Lisp, 
; so want a definition of list-of-values that evaluates left-to-right 
; regardless of the underlying implementation

; left->right
(define (list-of-values exps env)
    (if (no-operands? exps)
        `()
        (let ((first-val (eval (first-operand exps) env))))
            (cons first-val
                  (list-of-values (rest-operands exps) env))))

; right->left
(define (list-of-values exps env)
    (if (no-operands? exps)
        `()
        (let ((rest-vals (list-of-values (rest-operands exps) env))))
          (cons (eval (first-operand exps) env)
                (rest-vals))))