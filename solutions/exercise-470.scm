; What's the problem with?  Why do we need the let bindings?
(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (set! THE-ASSERTIONS
    (cons-stream assertion THE-ASSERTIONS))
  `ok)

; In this case, we would only ever see the new assertion
; as the stream is being defined recursively via set.
