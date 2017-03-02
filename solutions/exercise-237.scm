(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        `()
        (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
    (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
    (map dot-product m))

(define (transpose mat)
    (accumulate-n cons `() mat))

(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (v) (map dot-product v cols)) m)))
