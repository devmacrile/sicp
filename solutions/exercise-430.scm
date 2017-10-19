(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

; 57
; 321
; 88
;;; L-Eval value:
; done

; (a)
; Because eval is called on each individual expression,
; so if that is an application the actual value will be computed.

; (b)
(define (p1 x)
    (set! x (cons x '(2)))
    x)

(define (p2 x)
    (define (p e)
        e
        x)
    (p (set! x (cons x '(2)))))

(define (p3 x)
    (define (p e)
        e
        (display e)
        x)
    (p (set! x (cons x '(2)))))

(p1 1)
(p2 1)
(p3 1)

; With original eval-sequence
;;; L-Eval input:
; (p1 1)
;;; L-Eval value:
; (1 2)

;;; L-Eval input:
; (p2 1)
;;; L-Eval value:
; 1

; With explicitly forced eval-sequence
;;; L-Eval input:
; (p1 1)
;;; L-Eval value:
; (1 2)

;;; L-Eval input:
; (p2 1)
;;; L-Eval value:
; (1 2)

; e never gets evaluated in p2 as it is never forced

; (c)
; Because forcing something that has already been forced
; doesn't really change anything.

; (d)
; It seems actually somewhat confusing to not have expressions
; in a sequence actually forced in that sequence, so would 
; have to go with Cy's approach here, though it abandons a 'pure'
; laziness, whatever that may mean.
