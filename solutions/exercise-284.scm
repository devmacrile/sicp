; generic procedure defined in 2.83
(define (raise x)
    (apply-generic `raise x))


(define (is-above x y)
    ((let proc (get `raise (type-tag z)))
        (if proc
            (is-above x (proc y))
            #f)))

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (if (= (length args) 2)
                    (let ((type1 (car type-tags))
                          (type2 (cadr type-tags))
                          (a1 (car args))
                          (a2 (cadr args)))
                        (if (= type1 type2)
                            (error "No method for -this- type")
                            (if (is-above a1 a2)
                                (apply-generic op a1 (raise a2))
                                (apply-generic op (raise a1) a2))
                            (error "No method for these types"
                                   (list op type-tags)))))))))