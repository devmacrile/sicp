; Below is just a sketch - have not tried to run it 
(define (apply-generic op . args)
    ; coerce all the args, if it works return the functions, else nil
    (define (all-coercions to-type types coercions)
        (if (null? types)
            #t
            (let ((next-type (car types)))
                (let ((coercion (get-coercion next-type type)))
                    (if coercion
                        (all-coercions type (cdr types))
                        #f)))))

    ; find the type to which everything can be coerced
    (define (find-type types from-types)
        (if (null? types)
            (error "No method for these types" types)
            (let ((type (car types)))
                (let ((all-can-coerce (coerce-all type from-types `())))
                    (if all-can-coerce
                        type
                        (find-type (cdr types) from-types))))))

    (define (coerce-all args to-type)
        (map (lambda (arg)
                (let ((type (type-tag arg)))
                    (if (equal? type to-type)
                        arg
                        ((get-coercion type to-type) arg))))
             args))

    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (let ((type (find-type type-tags type-tags))
                    (if type
                        (apply-generic op (coerce-all args type))
                        (error "No common type for these types" type-tags))))))))


; Whenever we have a situation as described via fig 2.26 (i.e. a hierarchy of types).
; For example, a call to this apply-generic with both a square and an equilateral triangle
; in the arg list.  In this case their common supertype is the generic polygon, but neither
; would have a coercion method directly to their shared supertype, and so this would fail.
; i.e. need a "least-common-ancestor" approach.