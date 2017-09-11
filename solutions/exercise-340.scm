; All possible states of the following?
(define x 10)

(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

; 1e6: P1 sets x to 100, then P2 sets x to 100^3
; 1e5: P1 sets x to 100, P2 reads 10, 100, 100; sets x to 100,000
; 1e4: P1 sets x to 100, P2 reads 10, 10, 100; sets x to 10,000
; 1e3; P1 calculates 100, P2 calculates 1000; P1 sets, then P2 sets to 1000
; 100: ^Vice versa

; All possible states with serialization?
(define x 10)

(define s (make-serializer))

(parallel-execute (s (lambda () (set! x (* x x))))
                  (s (lambda () (set! x (* x x x)))))

; 1e6: P1 sets x to 100, then P2 reads 100 and sets x to 1e6 (or other way around).
; This is the only remaining possibility - and computation is the same both ways
; (i.e. all just multiples of 10).