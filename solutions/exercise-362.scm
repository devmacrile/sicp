; have mul-series and invert-unit-series in our toolbelt now
(define (div-series num-series den-series)
    (if (= (stream-car den-series) 0)
        (error "Non-zero constant term in denominator -- DIV-SERIES" (stream-car den-series))
        (let ((den-constant (stream-car den-series)))
            (mul-series num-series
                        (invert-unit-series 
                            (scale-stream den-series den-constant))))))

(define tan (div-series sine-series cosine-series))