(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error
                    "No method for these types -- APPLY-GENERIC"
                    (list op type-tags))))))

; (a)  
(define (get-record employee-name division-file)
    (apply-generic `get-record employee-name division-file))

; (b) 
(define (get-salary employee-record division)
    (apply-generic `get-salary employee-record division))


; (c) 
(define (find-employee-record employee-name division-files)
    (if (null? division-files)
        (error "Employee record could not be found -- FIND-EMPLOYEE-RECORD")
        (let (employee-record (get-record employee-name (car division-files)))
            (if (record)
                record
                (find-employee-record employee-name (cdr division-files))))))

; (d)
; The respective, specific get-record and get-salary functions must be implemented.
