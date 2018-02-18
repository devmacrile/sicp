; (load "evaluator.scm")
;(define count 0)
;(define (id x)
;    (set! count (+ count 1))
;    x)
;(define w (id (id 10)))



;(define (square x)
;    (* x x))
;
;(define count 0)
;(define (id x)
;    (set! count (+ count 1))
;    x)
;
;(square (id 10))

;count

; (load "evaluator_lazy.scm")
; 4.30
;(define (p1 x)
;    (set! x (cons x '(2)))
;    x)
;
;(define (p2 x)
;    (define (p e)
;        e
;        x)
;    (p (set! x (cons x '(2)))))
;
;(define (p3 x)
;    (define (p e)
;        e
;        (display e)
;        x)
;    (p (set! x (cons x '(2)))))

;(p1 1)
;(p2 1)
;(p3 1)


(load "evaluator_logic.scm")

(assert! (job (Bitdiddle Ben) (computer wizard)))
(assert! (salary (Bitdiddle Ben) 60000))

(assert! (job (Hacker Alyssa P) (computer programmer)))
(assert! (salary (Hacker Alyssa P) 40000))
(assert! (supervisor (Hacker Alyssa P) (Bitdiddle Ben)))

(assert! (job (Fect Cy D) (computer programmer)))
(assert! (salary (Fect Cy D) 35000))
(assert! (supervisor (Fect Cy D) (Bitdiddle Ben)))

(assert! (job (Tweakit Lem E) (computer technician)))
(assert! (salary (Tweakit Lem E) 25000))
(assert! (supervisor (Tweakit Lem E) (Bitdiddle Ben)))

(assert! (job (Reasoner Louis) (computer programmer trainee)))
(assert! (salary (Reasoner Louis) 30000))
(assert! (supervisor (Reasoner Louis) (Hacker Alyssa P)))

(assert! (supervisor (Bitdiddle Ben) (Warbucks Oliver)))
(assert! (job (Warbucks Oliver) (administration big wheel)))
(assert! (salary (Warbucks Oliver) 150000))

(assert! (can-do-job (computer wizard) (computer programmer)))
(assert! (can-do-job (computer wizard) (computer technician)))

(job ?x (computer programmer))

; 4.75
; Unique query schemas added to interpreter.
(and (job ?x ?j)
     (unique (supervisor ?anyone ?x)))
