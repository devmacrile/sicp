; generalized queries, e.g.
(sum ?amount
     (and (job ?x (computer programmer))
          (salary ?x ?amount)))

; of the form
; (accumulation-function <variable>
;                        <query pattern>)
;
; A query pattern does not inherently return unique values
; (as seen in 4.65) and so aggregations will not necessarily be valid.
; To salvage the situation, he would need some form of a "unique map"
; that only applies the mapped procedure to unique values.
