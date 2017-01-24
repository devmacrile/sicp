### Applicative order vs. normal order  

* Applicative order:  evaluate the arguments, then apply.  
* Normal order: fully expand and then reduce

Though normal-order evaluation can be useful, Lisp uses applicative-order (partly due to the additional efficiency obtained from avoiding multiple evaluations of expressions).  

For example, let:  

	(define (square x) (* x x))

	(define (sum-of-squares x y)
	  (+ (square x) (square y)))

	(define (f a)
	  (sum-of-squares (+ a 1) (* a 2)))

	(f 5)	

With applicative-order, the evaluation proceeds (conceptually) as:  

	(sum-of-squares (+ 5 1) ( * 5 2))
	(+ (square 6) (square 10))
	(+ (* 6 6) (* 10 10))
	(+ 36 10)  

whereas with normal-order, the evaluation would be:  

	(sum-of-squares (+ 5 1) (* 5 2))
	(+ (square (+ 5 1)) (square (* 5 2)))
	(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))  ; fully expanded, note the redundant calculations
	(+ (* 6 6) (* 10 10))
	(+ 36 100)  



### Distinction between 'process' and 'procedure'  (see p. 35)  

"One reason that the distinction between process and procedure may be confusing is that most
implementations of common languages (including Ada, Pascal, and C) are designed in sucha  way
that the interpretation of any recursive procedure consumes an amount of memory that grows
with the number of procedure calls, even when the process described is, in principle iterative.  
As a consequence, these languages can describe iterative processes only by resorting to 
special-purpose 'looping constructs' such as do, repeat, until, for, and while.  The implementation
of Scheme we shall consider in chapter 5 does not share this **defect**.  It will execute an
iterative process in constant space, even if the iterative process is described by a
recursive procedure."

"Defect" - nice.  
