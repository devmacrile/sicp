(define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          ((else (+ (fib (- n 1))
                    (fib (- n 2)))))))

(define memo-fib
    (memoize (lambda (n)
                (cond ((= n 0) 0)
                      ((= n 1) 1)
                      (else (+ (memo-fib (- n 1))
                               (memo-fib (- n 2))))))))

(define (memoize f)
    (let ((table (make-table)))
        (lambda (x)
            (let ((previously-computed-result (lookup x table)))
                (or previously-computed-result
                    (let ((result (f x)))
                        (insert! x result table)
                        result))))))

; global env --> [fib  memoize  memo-fib]
;
; (memo-fib 3)  ->  [E1 (memoize (lambda (3) ...)] -> [previously-computed-table] 
;                                 |                             ^      ^
;                          [E2 (lambda (3) ....)]               |      |
;                           /                   \               |      |
;                    [E3 memoize 2]         [E11 memoize 1] --lookup   |
;                     /        \                                       |
;         [E4 (lambda (2))]  [E9 (lambda (1))]                         |
;          /           \                \                              |
;    [E5 memoize 1] [E8 memoize 0]     [E10 memoize 1] -------------lookup     
;    /           \
;  [E6 lambda(2)] [E7 (lambda (1))]
;
;
; memo-fib computes the nth Fibonacci in O(n) because it never computes
; the value for the same number twice => so once for each of 1...n
; The scheme would not work if simply calling (memoize fib) because the lookup
; occurs within the call to memoize, and so recursive calls would not utilize
; the precomputed values.                 
