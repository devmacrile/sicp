; (a)
(define (div-streams s1 s2)
    (stream-map / s1 s2))

(define (integrate-series s)
    (div-streams s (integers-starting-from 1)))

; (b)
; x |--> e^x is its own derivative
(define exp-series
    (cons-stream 1 (integrate-series exp-series)))

; d/dx sinx = cosx
; d/dx cosx = -sinx
; (define negative-ones (cons-stream -1 negative-ones))
;
; (define (inverse-stream-additive s)
;    (mul-streams negative-ones s))
; ^ just use scale-stream

(define cosine-sine
    (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
    (cons-stream 0 (integrate-series cos-series)))