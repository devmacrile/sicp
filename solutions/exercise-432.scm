; Main advantage is having consistent interface, and thus
; procedures taking lists as arguments can work more generically
; (i.e. map, scale, add), while eliminating the need in the general
; case for explicit delay/force calls.  Also, as noted explicitly in the 
; text, certain non-sequential list structures become possible (lazy tree).

; Why a tree?
; As the car (and cdr for that matter) will no longer be evaluated on call,
; and as the car of a tree will recursively be a tree, this prevents evaluation
; down this (possibly infinite) branch.

; Going back to a stream exercise (3.79), we can reimplement
; as a lazy list to note the differences.

; stream (from 3.79)
(define (solve-2nd f y0 dy0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    (define ddy (stream-map f dy y))
    y)

; lazy list
(define (solve-2nd f y0 dy0 dt)
    (define y (integral dy y0 dt))
    (define dy (integral ddy dy0 dt))
    (define ddy (map f dy y))
    y)
