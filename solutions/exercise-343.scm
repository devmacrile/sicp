; Since balances are allowed to be negative, we'll always have
; the same amount of money between the three accounts, and since
; we're swapping round-robin, the balances will reamin $10, $20, 
; and $30 in some order.
; An e.g. of a violation of this given the first implementation 
; would be:
; a1 = 10, a2 = 20, a3 = 30
; (exchange a1 a2) (exchange a1 a3) and (exchange a2 a3) called concurrently
; first update occurs, and a1 is set to 20 and a2 is set to 10
; second exchange had the original read, but the first exchange finishes
; before the withdrawal and update so a1 is set to 0 and a3 is set to 50
; now the final exchange occurs and a2 is set to 50, a3 is set to 10
; so, final counts are a1 = 0, a2 = 50, and a3 = 10
; 
; Since the individual accounts are serialized, there will not be any
; funds lost in the mutating procedures (withdraw/deposity) => the sum
; of the accounts will remain $60 (as in the example).
;
; The latter part of the questions we've already seen, so passing.