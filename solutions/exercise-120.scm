(define (gcd a b)
	(if (= b 0)
		a
		(gcd b (remainder a b))))

(gcd 206 40)


; Normal-order evaluation



; Applicative-order evaluation