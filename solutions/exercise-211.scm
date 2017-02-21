(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (cdr x))

(define (lower-bound x)
    (car x))

; [a b], [c d]
; ------------
; [+ +], [+ +] => [ac, bd]
; [- +], [+ +] => [ad, bd]
; [- -], [+ +] => [ad, bc]
; [+ +], [- +] => [bc, bd]
; [- +], [- +] => [min(ad, bc), max(ac, bd)]
; [- -], [- +] => [ad, ac]
; [+ +], [- -] => [bc, ad]
; [- +], [- -] => [bc, ac]
; [- -], [- -] => [bd, ac]

(define (mul-interval x y)
    (let ((xl (lower-bound x))
        (xu (upper-bound x))
        (yl (lower-bound y))
        (yu (upper-bound y)))
    (cond ((and (> xl 0) (> xu 0) (> yl 0) (> yu 0))
             (make-interval (* xl yl) (* xu yu)))
          ((and (< xl 0) (> xu 0) (> yl 0) (> yu 0))
             (make-interval (* xl yu) (* xu yu)))
          ((and (< xl 0) (< xu 0) (> yl 0) (> yu 0))
             (make-interval (* xl yu) (* xu yl)))
          ((and (> xl 0) (> xu 0) (< yl 0) (> yl 0))
             (make-interval (* xu yl) (* xu yu)))
          ((and (< xl 0) (> xu 0) (< yl 0) (> yu 0))
             (make-interval (min (* xl yu)
                                 (* xu yl))
                            (max (* xl yl)
                                 (* xu yu))))
          ((and (< xl 0) (< xu 0) (< yl 0) (> yu 0))
             (make-interval (* xl yu) (* al yl)))
          ((and (> xl 0) (> xu 0) (< yl 0) (< yu 0))
             (make-interval (* xu yl) (* xl yu)))
          ((and (< xl 0) (> xu 0) (< yl 0) (< yu 0))
             (make-interval (* xu yl) (* xl yl)))
          ((and (< xl 0) (< xu 0) (< yl 0) (< yl 0))
             (make-interval (* xu yu) (* xl yl))))))

(mul-interval (make-interval -1 3) (make-interval -3 1))
