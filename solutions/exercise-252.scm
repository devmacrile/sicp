; a
; No patience

; b
(define (corner-split painter n)
    (if (= n 0)
        painter
        (let ((up (up-split painter (- n 1)))
              (right (right-split painter (- n 1)))
              (corner (corner-split painter (- n 1))))
        (beside (below painter up)
                (below right corner)))))

; c
; Just have to change the order of operations to square-of-four
(define (square-limit painter n)
    (let ((combine4 (square-of-four identity flip-horiz
                                    flip-vert rotate180)))
    (combine4 (corner-split painter n))))