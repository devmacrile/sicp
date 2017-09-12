; withdraw/deposit are serialized as before
(define (transfer from-account to-account amount)
    ((from-account `withdraw) amount)
    ((to-account `deposit) amount))

; Since each accessor is serialized, this should be fine.  A key difference
; from the exchange problem is that there is no need to access the account
; balance to compute a difference.  The only separation here is between the
; withdrawal and the deposit, but since these values do not depend on each other,
; there isn't much that can go wrong.