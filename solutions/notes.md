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
implementations of common languages (including Ada, Pascal, and C) are designed in such a  way
that the interpretation of any recursive procedure consumes an amount of memory that grows
with the number of procedure calls, even when the process described is, in principle iterative.  
As a consequence, these languages can describe iterative processes only by resorting to 
special-purpose 'looping constructs' such as do, repeat, until, for, and while.  The implementation
of Scheme we shall consider in chapter 5 does not share this **defect**.  It will execute an
iterative process in constant space, even if the iterative process is described by a
recursive procedure."

"Defect" - nice.  


Discussion of means of combinations being "closures" (i.e. results of combination can in 
turn be combined using the same operation).  
"In Pascal the plethora of declarable data structures induces a specialization within functions
that inhibits and penalizes casual cooperation.  It is better to have 100 functions that operate 
on one data structure than to have 10 functions that operate on 10 data structures."
-- Alan Perlis quote (p. 99)

'nil' is a contraction of the latin word nihil, which means "nothing".  Interesting tidbit.

Richard Waters developed a program that automatically analyzes traditional Fortran programs,
viewing them in terms of maps, filters, and accumulations.  He found that fully 90% of the
code in the Fortran Scientific Subroutine Package fits neatly into this paradigm.
-- Footnote on p. 118


### Sameness and change (3.1.3)  

A language that supports the concept that "equals can be substituted for equals" in
an expression without changing the value of the expression is said to be
_referentially transparent_.  Referential transparency is violated when we include
set! in our language => makes it tricky to determine when we can simplify
expressions via substitution and reasoning about programs that use assignment becomes
more difficult.

Programming that makes extensive use of assignment is called _imperative programming_.

aliasing = single computational object being accessed by more than one name
