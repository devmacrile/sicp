; semaphore (of size n) is a generalized mutex
; implement in terms of mutexes, and directly in terms of atomic 
; test-and-set! operations.  slightly confused about implement the 
; notion of 'in terms of' a mutex, as you cannot simply check the 
; state of a mutex (i.e. passing `acquire message is a blocking call), 
; so it must be that we should utilize the mutex in our implementation.

; using mutex
(define (semaphore n)
    (let ((count 0)
          (mutex (make-mutex)))
        (define (the-semaphore m)
            (cond ((eq? m `acquire)
                     (mutex `acquire)
                     (cond ((count < n)
                            (set! count (+ count 1))
                            (mutex `release))
                           (else
                            (mutex `release)
                            (the-semaphore `acquire)))
                   ((eq? m `release)
                      (mutex `acquire)
                      (set! count (- count 1))
                      (mutex `release))))
        the-semaphore))


; using atomic test-and-set! ops
; atomic implementation of test-and-set! for 
; MIT Scheme; (without-interrupts <..>) prevents
; time-slicing between processes.
(define (test-and-set! cell)
    (without-interrupts
        (lambda ()
            (if (car cell)
                true
                (begin (set-car! cell true)
                        #f)))))


(define (semaphore n)
    (let ((count 0)
          (cell (list #f)))
        (define (the-semaphore m)
            (cond 
                ((eq? m `acquire)
                     (cond 
                        ((test-and-set! cell)
                            (the-semaphore `acquire))
                        ((not (test-and-set! cell))
                            (cond 
                                ((count < n)
                                    (set! count (+ count 1))
                                    (clear! cell))
                                (else
                                    (clear! cell)
                                    (the-semaphore `acquire))))))
                ((eq? m `release)
                    (cond
                        ((test-and-set! cell)
                            (the-semaphore `release))
                        ((not (test-and-set! cell))
                            (set! count (- count 1))
                            (clear! cell))))))
        the-semaphore))
