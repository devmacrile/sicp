(define (random-numbers input-stream)
    (let ((init ((random-init))))
        (define (dispatch x m)
            (if (eq? m `reset)
                init
                (rand-update x)))
        (cons-stream init
                     (stream-map dispatch (random-numbers input-stream) input-stream))))