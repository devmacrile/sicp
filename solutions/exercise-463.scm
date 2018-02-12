(rule (grandson ?s ?g)
      (and (son ?s ?f)
	   (son ?f ?g)))

(rule (father ?m ?s)
      (or (son ?s ?m)
           (and (son ?s ?w)
	        (wife ?w ?m))))

; grandson of cain
(grandson ?s Cain)

; sons of Lamech
(son ?s Lamech)  ; or
(father Lamech ?s)

; grandsons of Methushael
(grandson ?s Methushael)
