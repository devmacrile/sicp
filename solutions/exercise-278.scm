; refactor a couple of functions to utilize scheme's internal
; dispatching (basically means we wouldn't have to create a 
; whole package for scheme-number in our generic arithmetic system)

(define (attach-tag type-tag contents)
    (if (number? contents)
        contents
        (cons type-tag contents))

(define (type-tag datum)
    (cond ((pair? datum) (car datum))
          ((number? datum) datum)
          (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
    (cond ((pair? datum) (cdr datum))
          ((number? datum) (cdr datum))
          (else (error "Bad tagged datum -- CONTENTS" datum))))