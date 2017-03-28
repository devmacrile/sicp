; Alter set representation to allow for duplicates
; Efficiency differences?

; No change
(define (element-of-set? x set)
    (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

; Just add it no matter what
; Reduces O(n) to O(1)
(define (adjoin-set x set)
    (cons x set))

; No change, unless want dups removed here
(define (intersection-set set1 set2)
    (cond ((or (null? set1) (null? set2)) `())
        ((element-of-set? (car set1) set2)
            (cons (car set1)
                  (intersection-set (cdr set 1) set2)))
        (else (intersection-set (cdr set1) set2))))

; No change
(define (union-set set1 set2)
    (if (null? set1) 
        set2 
        (union-set (cdr set1) (adjoin-set (car set1) set2))))

; If you're encountering a bunch of objects and simply want to know
; if a certain object has been encountered before, this could be 
; a prefereable representation (slower lookup, but much faster insertion)