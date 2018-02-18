; Maintain a "call stack" of rules being evaluated with their frames, and
; any time a rule is to be evaluated check that the rule is not already
; present in the stack of calls being evaluated.
;
; A bit awkard to design this without looking ahead to the implementation in detail.  
; But would say we simply want to check that the pattern and the bindings within
; the frames are identical.
;
; In this case, the frame would look like (staff-person => (Bitdiddle Ben)) and
; the pattern would be (outranked-by (Bitdiddle Ben) ?who) with an unbound ?who.  
; This match would then be found, and an empty stream of frames should be returned.
