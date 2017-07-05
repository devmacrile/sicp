; recursive factorial
(define (factorial n)
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))

; global env --> [factorial]
;                 |
;                [()()]
;                parameters: n
;                body: (if (= n 1)) ...
;
;  global env --> [                                                          ]
;                           |                        |
;  (factorial 6)  E1 --> [n: 6]             E2 --> [n: 5]               .....
;                         (if (= n 1))...           (if (= n 1))...

; iterative factorial
(define (factorial n)
    (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
                   (+ counter 1)
                   max-count)))

; global env --> [factorial       fact-iter]
;                   |                 |
;                 [()()]            [()()]
;         parameters: n          parameters: product counter max-count
;         body:                  body: (if (> counter ...
;            (fact-iter 1 1 )        
;
; In the evaluation diagram will have one environment, E1, representing the 
; factorial procudure, and a collection of environments for each call to 
; fact-iter all pointing back to the global environment. 