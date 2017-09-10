(define a (make-connector))
(define b (make-connector))
(set-value! a 10 `user)

; call to (set-value! ...) above will at some point
; cause the following to be evaluated:
; (for-each-except setter inform-about-value constraints)

; Nah.  Connector has no value yet, so value gets set
; to the new value passed (10), and the informant gets
; set to `user as passed.  No constraints on the connector
; yet, so that remains `().