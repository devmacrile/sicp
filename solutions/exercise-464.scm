(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (outranked-by ?middle-manager ?boss)
               (supervisor ?staff-person ?middle-manager))))

; This enters an infinite loop because both clauses of an `or` must 
; be evaluated, and the `and` clause will always recursively evaluate outranked-by
; recursively, and since this call has a new variable to be bound, it will 
; include (Bitdiddle Ben), which will create the same outranked-by evaluation.
