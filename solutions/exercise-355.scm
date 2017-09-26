(define (partial-sums s)
    (cons-stream (stream-car s) 
                 (add-streams s (partial-sums s))))