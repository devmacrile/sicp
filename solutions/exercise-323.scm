; The O(1) requirement for each operation means that we'll need 
; a way to get from the rear pointer to its predecessor.
;
; So we'll let the car of a pair be a pointer to its predecessor, 
; and cdr be its actual data.
; 
; Edit: above got messy pretty quickly, so adding another abstraction
; for a pointer to make reasoning easier.

(define (front-ptr deque)
    (car deque))

(define (rear-ptr deque)
    (cdr deque))

(define (make-ptr item)
    (cons item (cons `() `())))

(define (get-value ptr)
    (car ptr))

(define (get-prev ptr)
    (cadr ptr))

(define (get-next ptr)
    (cddr ptr))

(define (set-prev! ptr prev)
    (set-car! (cdr ptr) prev))

(define (set-next! ptr next)
    (set-cdr! (cdr ptr) next))

(define (set-front-ptr! deque item)
    (set-car! deque item))

(define (set-rear-ptr! deque item)
    (set-cdr! deque item))

(define (empty-deque? deque)
    (null? (front-ptr deque)))

(define (make-deque)
    (cons `() `()))

(define (rear-deque deque)
    (if (empty-deque? deque)
        (error "READ called with an empty deque" deque)
        (get-value (rear-ptr deque))))

(define (front-deque deque)
    (if (empty-deque? deque)
        (error "FRONT called with an empty deque" deque)
        (get-value (front-ptr deque))))

(define (front-insert-deque! deque item)
    (let ((new-ptr (make-ptr item)))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-ptr)
               (set-rear-ptr! deque new-ptr)
               deque)
              (else
               (set-prev! (front-ptr deque) new-ptr)
               (set-next! new-ptr (front-ptr deque))
               (set-front-ptr! deque new-ptr)
               deque))))

(define (rear-insert-deque! deque item)
    (let ((new-ptr (make-ptr item)))
        (cond ((empty-deque? deque)
               (set-front-ptr! deque new-ptr)
               (set-rear-ptr! deque new-ptr))
              (else
                (set-next! (rear-ptr deque) new-ptr)
                (set-prev! new-ptr (rear-ptr deque))
                (set-rear-ptr! deque new-ptr)))))

(define (front-delete-deque! deque)
    (cond ((empty-deque? deque)
           (error "FRONT-DELETE! called with an empty deque" deque))
          (else
            (let ((new-front (get-next (front-ptr deque))))
                (if (null? new-front)
                    (make-deque)
                    (begin 
                        (set-front-ptr! deque new-front)
                        (set-prev! new-front `())
                        deque))))))

(define (rear-delete-deque! deque)
    (cond ((empty-deque? deque)
           (error "REAR-DELETE! called with an empty deque" deque))
          (else
            (let ((new-rear (get-prev (rear-ptr deque))))
                (if (null? new-rear)
                    (make-deque)
                    (begin 
                        (set-rear-ptr! deque new-rear)
                        (set-next! new-rear `())
                        deque))))))

(define (print-deque deque)
  (define (print-iter ptr items)
    (if (null? ptr)
        (display items)
        (print-iter (get-next ptr)
                    (append items 
                            (list (get-value ptr))))))
  (print-iter (front-ptr deque) (list)))


; Took me way too long to remember/realize that these mutating
; functions are automatically pumped to display in the
; interpreter, so have to ensure that the only time they
; are 'printed' is via our special method (as warned).
; i.e. defining:
; (define q1 (make-deque))
; (front-insert-deque! q1 `a)
; (rear-insert-deque! q1 `b)
; causes a recursion-depth-limit error due to this.
(define (test-main)
  (let ((q1 (make-deque)))
    (front-insert-deque! q1 `a)
    (newline)
    (print-deque q1)

    (rear-insert-deque! q1 `b)
    (newline)
    (print-deque q1)

    (front-insert-deque! q1 `c)
    (newline)
    (print-deque q1)
    
    (front-delete-deque! q1)
    (newline)
    (print-deque q1)

    (rear-delete-deque! q1)
    (newline)
    (print-deque q1)))
(test-main)
