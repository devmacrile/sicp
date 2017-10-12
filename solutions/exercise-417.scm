; Extra frame is from the context created by the 
; introduction of the let.
;
; Will never make a difference because all of the
; assignments are guaranteed to come before the 
; body expressions.
;
; To have "simultaneous" scope for internal definitions
; without the extra frame, we could just get rid of the
; let, which simply places the variables (i.e. u, v) 
; in scope.. so if all the definitions are placed so as
; to come before the actual body expressions, we do 
; not need the let expression.
