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


### Concurrency (3.4)  

Mutex implementation (3.4.2) ironically could be susceptible
to the exact problems it is trying to help solve.  The implementation of testing and
setting the mutex must ensure that no concurrent reads occur between these after
setting but before the testing return.  The actual implementation here actually
depends on the details of how the underlying system runs concurrent processes.  It could
use time-slicing with a sequential processor: cycling through the processes and
running each a little bit, interrupting it, and repeating with the next process.  Or it
could have instructions with atomic operations built into the underlying hardware. (**)

If the scenario is time-slicing on a single processor, MIT Scheme (the implementation I
have been using throughout the exercises) would implement test-and-set! as:

    (define (test-and-set! cell)
        (without-interrupts
            (lambda ()
                (if (car cell)
                    true
                    (begin (set-car! cell true)
                           false)))))

Key point being the use of (without-interrupts <...>).


### Streams (3.5)  

An alternative approach to modelling state, based on data structures called streams.

Motivating questions:  

* Can we avoid identifying time in the computer with time in the modeled world?  
* Must we make the model change with time in order to model phenomena in a changing world?  


If time is measured in discrete steps, then we can model a time function as a (possibly
infinite) sequence.  Stream is a sequence with delayed evaluation.  They can allow us
to model systems that have state without ever using assignment or mutable data (but of
course have challenges of their own).

Explicit use of `delay and `force gives us a ton of flexibility, but adds complexity
to the usage (i.e. remembers to pass delayed arguments).  Basically, now have two classes
of procedures: ordinary, and those that take delayed arguments.  And this forces us to create
separate classes of higher-order procedures as well.  Great footnote (72):

    > This small reflection, in Lisp, of the difficulties that conventional strongly typed
    languages such as Pascal have in coping with higher-order procedures.  In such languages,
    the programmer must specify the data types fo the arguments and the result of each proc-
    edure: number, logical value, sequence, and so on.  Consequently, we could not express an
    abstraction such as "map a given procedure proc over all the elements in a sequence" by
    a single higher-order procedure such as stream-map.  Rather, we would need a different
    mapping procedure for each different combination of argument and result data types that
    might be specified for a proc...  

One option would be to automatically delay all arguments and only force them when needed.  This
change would make our language use normal-order evaluation (see above, 1.1.5).  An elegant way
to simplify delayed evaluation, and would be a good choice if stream processing were the only
concern; but, this destroys our ability to design programs that depend on the ordering of time,
i.e. programs that use assignment, mutate data, or perform i.o.  tldr; mutability and delayed
evaluation do not mix well in programming languages.

Gist of chapter three: started out modelling systems with state by relating hte temporal behavior
of objects in the world to the temporal behavior of corresponding computational objects.  Streams
provide an alternative way to model objects with local state: we can model a changing quantity
using a stream that represents the time history of successive states, essentially representing
time _explicitly_ (time in real world decoupled from computational time).  


### Metacircular evaluation (4.1)  

"The evaluator, which determines the meaning of expressions in a programming language, is just 
another program."  

Evaluation:  

  1.  (combinations) Evaluate subexpressions, apply value of operator subexpression to values of 
      operand subexpression.  
  2.  (compound procedure)  Evaluate body of procedure in new environment (extending environment 
      part of procedure object by a frame in which parameters are bound to arguments to which procedure 
      is applied).  

Our evaluator for Lisp will be implemented as a Lisp program; an evaluator written in the same
language that it evaluates is called *metacircular*.  

    (define (eval exp env)
        (cond ((self-evaluating? exp) exp)
              ((variable? exp) (lookup-variable-value exp env))
              ((quoted? exp) (text-of-quotation exp))
              ((assignment? exp) (eval-assignment exp env))
              ((definition? exp) (eval-definition exp env))
              ((if? exp) (eval-if exp env))
              ((lambda? exp)
                (make-procedure (lambda-parameters exp)
                                (lambda-body exp)
                                env))
              ((begin? exp)
                (eval-sequence (begin-actions exp) env))
              ((cond? exp) (eval (cond->if exp) env))
              ((application? exp)
                (apply (eval (operator exp) env)
                       (list-of-values (operands exp) env)))
              (else
                (error "Unkown expression type -- EVAL" exp))))  

In a real implementation, dispatch would be done in a data-directed style s.t. the definition of `eval`
would not have to change if new expression types were added.  

A language, as we know, is comprised of **primitives**, **means of abstraction**, and **means of combination**.  

#### Data as Programs (4.1.5)  

The evaluator can be thought of as a special machine that takes as input a description of a machine, and
with this input configures itself to emulate the machine described.  So our evaluator is a *universal machine*.  

    The deep idea here is that any evaluator can emulate any other.  Thus, the notion of "what can in principle
    be computed" (ignoring practicalities of time and memory required) is independent of the language or the
    computer, and instead reflects an underlying notion of computability. 

    ...

    Some people find it counterintuitive that an evaluator, which is implemented by a relatively simple procedure,
    can emulate programs that are more complex than the evaluator itself.  The existence of a universal evaluator 
    machine is a deep and wonderful property of computation.  

#### Amb and Search (4.3.1)  

Introduces the concept of *nondeterministic computing*, which erodes the distinction between declarative descriptions
and imperative specifications of computational procedures (pre*amb*le to prolog).

*amb* is shorthand for ambiguous => i.e. the expression  

	(amb <e1> <e2> ... <en>)  

returns the value of one of the n expressions *ambiguously*. The idea of amb was introduced by John McCarthy (circa 1961).  

The advantage of this style of programming is that the details of how search is performed are maskes s.t. we can operate at 
a higher level of abstraction. 

#### Is Logic Programming Mathematical Logic?  

tldr; no.  The query language provides a control structure that interprets logical statements procedurally, and this control 
structure can be taken advantage of (i.e. logically equivalent forms having different performance characteristics or 
even (gasp) different return values (in the given implementation as streams of frames)).  

    The aim of logic programming is to provide the programmer with techniques for decomposing a computational problem into two
    separate problems: "what" is to be computed, and "how" this should be computed.  This is accomplished by selecting a subset
    of the statements of mathematical logic that is powerful enough to be able to describe anything one might want to compute, yet
    weak enough to have a controllable procedural implementation.  

One crucial difference here too is in the interpretation of *not*.  In logic programming, *not* moreso means that a given
proposition is not deducible from the known; or, the not reflects the *closed worl assumption* that all relevant information
is available.  See Clark (1978) for a longer discussion on this topic (paper is called Negation as Failure).  


