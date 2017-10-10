(define (cond-test-clause? clause)
    (eq? (cadr clause) `=>))

(define (expand-clauses clauses)
    (if (null? clauses)
        #f
        (let ((first (car clauses))
              (rest (cdr clauses)))
          (if (cond-else-clause? first)
                    (if (null? rest)
                        (sequence->exp (cond-actions first))
                        (error "ELSE clause isn't last -- COND->IF" clauses))
              (if (cond-test-clause? first)
                    (make-if (cond-predicate first)
                             (list (cadr (cond-actions first)) (cond-predicate first))
                             (expand-clauses rest))
                    (make-if (cond-predicate first)
                             (sequence->exp (cond-actions first))
                             (expand-clauses rest)))))))