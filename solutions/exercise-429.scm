; Any recursively defined procedure really benefits
; from the memoization as the procedure is not re-evaluated
; on each sub-call.

(define count 0)
(define (id x)
    (set! count (+ count 1))
    x)
(define (square x)
    (* x x))

; with memoization
;;; L-Eval input:
(square (id 10))
;;; L-Eval value:
100

;;; L-Eval input:
count
;;; L-Eval value:
1


; without memoization
;;; L-Eval input:
(square (id 10))
;;; L-Eval value:
100

;;; L-Eval input:
count
;;; L-Eval value:
2

; argument is (id 10) which gets called twice in
; the non-memoized version.