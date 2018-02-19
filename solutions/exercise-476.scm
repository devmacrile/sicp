(define (conjoin conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
    frame-stream
    (merge (qeval (first-conjunct conjuncts) frame-stream)
           (conjoin (rest-conjuncts conjuncts) frame-stream))))

(define (merge-frame-streams fs1 fs2)
  (cons ((stream-null? fs1)
         fs2)
        ((stream-null? fs2)
         fs1)
        (stream-flatmap
          (lambda (f1)
            (stream-flatmap
              (lambda (f2)
                (merge-frames f1 f2))
              fs2))
          fs1)))

(define (merge-frames f1 f2)
  (if (null? f2)
    f1
    (let ((var (binding-variable (car f2)))
          (val (binding-value (car f2))))
      (let ((extended (extend-if-possible var val f1)))
        (if (eq? f1 `failed)
          `failed
          (merge-frame extended (cdr f2)))))))

