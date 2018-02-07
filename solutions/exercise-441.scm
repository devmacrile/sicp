(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
    (accumulate append `() (map proc seq)))

(define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
	              sequence))

(define (zip lista listb)
  (if (not (= (length lista) (length listb)))
    (error "ZIP -- lists must be the same length")
    (if (null? (cdr lista))
      (list (car lista) (car listb))
      (append (list (car lista) (car listb)) (zip (cdr lista) (cdr listb))))))

(define (distinct? items)
  (cond ((null? items) true)
	((null? (cdr items)) true)
	((member (car items) (cdr items)) false)
	(else (distinct? (cdr items)))))

(define (multiple-dwellings)
  (define names (list `baker `cooper `fletcher `miller `smith))
  (define (enumerate-assignments)
    (define (permutations s)
      (if (null? s)
        (list `())
        (flatmap (lambda (x)
                   (map (lambda (p) (cons x p))
                        (permutations (remove x s))))
                 s)))
    (permutations (list 1 2 3 4 5)))

  ; here, distinct goes without saying as we are
  ; generating permutations without replacement, but
  ; we'll leave it in for clarity of correctness
  (define (checks-out? dwellings)
    (and (not (= (list-ref dwellings 0) 5))
	 (not (= (list-ref dwellings 1) 1))
	 (not (= (list-ref dwellings 2) 5))
	 (not (= (list-ref dwellings 2) 1))
	 (> (list-ref dwellings 3) (list-ref dwellings 1))
	 (not (= (abs (- (list-ref dwellings 2) (list-ref dwellings 4))) 1))
	 (not (= (abs (- (list-ref dwellings 2) (list-ref dwellings 1))) 1))))
	 ;(distinct? dwellings)))

  (let ((assignments
	  (filter checks-out? (enumerate-assignments))))
    (if (null? assignments)
      (error "MULTIPLE-DWELLINGS -- no solutions found.")
      (zip names (car assignments)))))


(multiple-dwellings)
