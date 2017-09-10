; adder/multiplier already defined
; as primitives in our language
(define (averager a b avg)
    (let ((sum (make-connector))
          (n (make-connector)))
        (adder a b sum)
        (constant n 2)
        (multiplier avg n sum)))