
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((and (and (not (= base (- m 1))) (not (> base 1))) (= (remainder (square base) m) 1)) 0)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m)) m))
	(else
	 (remainder (* base (expmod base (- exp 1) m)) m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))


(miller-rabin-test 2)
(miller-rabin-test 17)
(miller-rabin-test 51)
(miller-rabin-test 97)
(miller-rabin-test 106)
(miller-rabin-test 561)
(miller-rabin-test 1105)
(miller-rabin-test 6601)
(miller-rabin-test 10000)
