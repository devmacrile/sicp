(define (make-table same-key?)
    (let ((local-table (list `*table*)))
        ; redefine assoc to use passed procedure
        (define (assoc key records)
            (cond ((null? records) #f)
                  ((same-key? key (caar records)) (car records))
                  (else (assoc key (cdr records)))))
        (define (lookup keys)
            (define (lookup-iter keys table)
                (if (null? (cdr keys))
                    (let ((record (assoc (car keys) (cdr table))))
                        (if record
                            (cdr record)
                            #f))
                    (let ((subtable (assoc (car (keys) (cdr table)))))
                        (if subtable
                            (lookup-iter (cdr keys) subtable)
                            #f))))
            (lookup-iter keys local-table))
        (define (insert! keys value)
            (define (insert-iter keys table)
                (if (null? (cdr keys))
                    (let ((record (assoc (car keys) (cdr table))))
                        (if record
                            (set-cdr! record value)
                            (set-cdr! subtable
                                      (cons (cons (car keys) value)
                                            (cdr table)))))
                    (let ((subtable (assoc (car (keys) (cdr table)))))
                        (if subtable
                            (insert-iter (cdr keys) subtable)
                            (set-cdr! table
                                      (cons (list (car keys)
                                                  (cons (cdr keys) value))
                                            (cdr table)))))))
            (insert-iter keys local-table))
        (define (dispatch m)
            (cond ((eq? m `lookup-proc) lookup)
                  ((eq? m `insert-proc!) insert!)
                  (else (error "Unknown operation -- TABLE" m))))
        dispatch))