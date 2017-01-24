; Procedure to recursively compute Pascal's triangle

(define (pascal row col)
	(if (or (= col 1) (= row col)) 
		1
		(+ (pascal (- row 1) col) 
		   (pascal (- row 1) (- col 1)))))

(pascal 1 1)
(pascal 5 5)
(pascal 5 3)
(pascal 6 4)
