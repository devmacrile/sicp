; One simpler way to do this with the current instantiation of the evaluator would be
; to preprocess conjuncts s.t. not and/or lisp-value are processed later in the query
; evaluation (in the case of not, maybe providing a non-empty stream to work on; in the case
; of lisp-value, allowing more context for variables to be fully bound).  
;
; This would be difficult in general though, so the promise idea is more correct. We would
; do this by adding some type checking logic into the conjoin procedure for complex queries in 
; order to capture the issues of respective interest for not and lisp-value.
;
; Ugly demonstration below, but we get the idea.

(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
    frame-stream
    (if (and (stream-null? frame-stream)
             (eq? (type (first-conjunct conjuncts)) `and)
             (has-nonnot-conjunct rest-conjuncts))
      (conjoin (add-conjunct (first-conjunct conjuncts) (rest-conjuncts conjuncts))
               (qeval (first-conjunct (rest-conjuncts)) frame-stream)))))
