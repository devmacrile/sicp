; Louis' suggestion
(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list `verb-phrase
	     (parse-verb-phrase)
	     (parse-prepositional-phrase))))

; This should work equivalently in behavior.  If we allow the interchanging of
; order of amb expressions, however, this will not work.. if the second expression
; goes first, it will recursively call parse-verb-phrase and thus amb.
