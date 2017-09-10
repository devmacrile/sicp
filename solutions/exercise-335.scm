; define squarer properly as a primitive
(define (squarer a b)
    (define (process-new-value)
        (if (has-value? b)
            (if (< (get-value b) 0)
                (error "square less than 0 -- SQUARER" (get-value b))
                (set-value! a (sqrt (get-value b)) me))
            (if (has-value? a)
                (set-value! b (square (get-value a)) me)
                (error "neither connector has valid value -- SQUARER"))))

    (define (process-forget-value)
        (forget-value! a)
        (forget-value! b)
        (process-new-value))

    (define (me request)
        (cond ((eq? request `I-have-a-value)
               (process-new-value))
              ((eq? request `I-lost-my-value)
                (process-forget-value))
              (else
                (error "Unknown request -- SQUARER" request))))

    (connect a me)
    (connect b me)
    me)