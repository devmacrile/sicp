; This form is more degenerate in the cases we've seen with infinite loops
; in rule definitions.  With the delay form, we at least get a stream
; of answers, even if they cycle infinitely - whereas here we would get no
; answers returned at all.
;
; I also suspect the delayed form would have better performance w.r.t. memory,
; though not 100% on this hunch.
