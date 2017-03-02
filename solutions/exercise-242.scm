(define (reverse sequence)
    (fold-right (lambda (x y) (append y (list x))) `() sequence))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
    (if (> low high)
        `()
        (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
    (accumulate append `() (map proc seq)))

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens)
                        (map (lambda (new-row)
                            (adjoin-position new-row k rest-of-queens))
                        (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    (queen-cols board-size))

(define (adjoin-position new-row k rest-of-queens)
    (append rest-of-queens (list (cons new-row k))))

(define empty-board `())

(define (all proc items)
    (define (iter items)
        (cond ((null? items) #t)
            ((proc (car items)) (iter (cdr items))) 
            (else #f)))
    (iter items))

; None in row, and none in either diagonal
(define (safe? k positions)
    (define (safe-combo? a b)
        (not (or (= (car a) (car b))
                 (= (abs (- (car a) (car b)))
                    (abs (- (cdr a) (cdr b)))))))
    (all (lambda (p) (safe-combo? (car (reverse positions)) p)) (cdr (reverse positions))))

; for reasoning
(queens 4)
; Looked it up, should be 92
(length (queens 8))

; Took me a while on this one to understand what was being asked (even though it is
; explicit in the implementation of 'queens').  They are adding candidate queens to
; positions, and asking if that new candidate is a valid placement - the parameter k
; does not even need to be utilized (though you could for list access as opposed to
; reversing the positions structure?)
