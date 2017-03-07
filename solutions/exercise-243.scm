; The recursive call to queen-cols is now inside the inner map call,
; so for each candidate it is called k times instead of once.
; If the original program takes time T, then this fudged version will
; take T * k^2