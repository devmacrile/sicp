(define fibs
    (cons-stream 0
                 (cons-stream 1
                              (add-streams (stream-cdr fibs)
                                           fibs))))
; How many additions are performed to compute the nth fibonacci number?
;   (n - 1) additions would be performed.
; Show this would be exponentially greater without the use of memoization
; in the implementation of (delay <exp>).
;   The (stream-cdr fibs) call would recompute everything that fibs itself
;   is computing, and so there would be exponentially as many additions.