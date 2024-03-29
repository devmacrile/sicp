(define (make-wire)
    (let ((signal-value 0) (action-producures `()))
        (define (set-my-signal! new-value)
            (if (not (= signal-value new-value))
                (begin (set! signal-value new-value)
                       (call-each action-procedures))
                `done))

        (define (accept-action-procedure! proc)
            (set! (action-procedures (cons proc action-procedures)))
            (proc))

        (define (dispatch m)
            (cond ((eq? m `get-signal) signal-value)
                  ((eq? m `set-signal) set-my-signal!)
                  ((eq? m `add-action!) accept-action-procedure!)
                  (else (error "Unknown operation -- WIRE" m))))
        dispatch))

(define (call-each procedures)
    (if (null? procedures)
        `done
        (begin
            ((car procedures))
            (call-each (cdr procedures)))))

(define (get-signal wire)
    (wire `get-signal))

(define (set-signal! wire new-value)
    ((wire `set-signal!) new-value))

(define (add-action! wire action-procedure)
    ((wire `add-action!) action-procedure))

(define (after-delay delay action)
    (add-to-agenda! (+ delay (current-time the-agenda))
                    action
                    the-agenda))

(define (propagate)
    (if (empty-agenda? the-agenda)
        `done
        (let ((first-item (first-agenda-item the-agenda)))
            (first-item)
            (remove-first-agenda-item! the-agenda)
            (propagate))))

(define (probe name wire)
    (add-action! wire
                 (lambda ()
                    (newline)
                    (display name)
                    (display " ")
                    (display (current-time the-agenda))
                    (display " New-value = ")
                    (display (get-signal wire)))))


; This initialization is necessary because it ensures that the gates
; operate on the correct inputs (esp. the initial values being propagated
; properly), i.e. the state is in sync.
; Specifically in the case of the example in 3.3.4, the way the wires and actions
; interact with the agenda require the evaluate of the added action procs to occur
; so that actions exist in the agenda; else the call to (propagate) will just be
; called on an empty agenda.
