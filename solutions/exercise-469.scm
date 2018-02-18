(rule (grandson ?s ?g)
      (and (son ?s ?f)
       (son ?f ?g)))

(rule (father ?m ?s)
      (or (son ?s ?m)
           (and (son ?s ?w)
            (wife ?w ?m))))

(rule (ends-in-grandson (grandson)))
(rule (ends-in-grandson (?u . ?v))
      (ends-in-grandson ?v))

(rule ((great . ?rel) ?x ?y)
      (and (ends-in-grandson ?rel)
           (father ?z ?y)
           (?rel ?z ?y)))

; ((great grandson) ?g ?ggs)
; (?relationship Adam Irad)

