(rule (wheel ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))

(wheel ?who)

; returns
(wheel (Warbucks Oliver))
(wheel (Bitdiddle Ben))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))

; Oliver Warbucks is probably listed four times because he satisfies
; the wheel condition four separate times (i.e. has four middle-managers
; reporting to him).
