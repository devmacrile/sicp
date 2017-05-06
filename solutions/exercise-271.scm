; For n=5, we have symbol weidhts of:
;   1, 2, 4, 8, 16
;
;    {a b c d e} 31
;       /   \
;     a 16   {b c d e} 15
;             /      \
;           b 8   {c d e} 7
;                    /  \
;                  c 4  {d e} 3
;                        /  \
;                       d 2  e 1
;               
; One bit to encode the most frequent symbol, 4 bits to encode the least
; frequent symbol.
;
; In general, for an n symbol alphabet with power of two frequencies,
; the relationship will be one bit and (n - 1) bits for most/least frequent,
; respectively.