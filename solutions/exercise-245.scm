(define (split proc subproc)
    (lambda (painter n)
        (if (= n 0)
            painter
            (let ((smaller ((split proc subproc) (- n 1))))
                (proc painter (subproc smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))
