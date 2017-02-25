(list 1 (list 2 (list 3 4)))
; (1 (2 (3 4)))


; Recall (cons 1 2) box-and-pointer representation
;   
;  ----> [*][*] --> [2]
;         |  
;        [1]
;
; For last element in list
; --> [*][/]
;      |
;      x


; Box-and-pointer representation
; --> [*][*] --> [*][/]
;      |          |
;     [1]        [*][*] --> [*][/]
;                 |          |
;                [2]        [*][*] --> [*][/]
;                            |          |
;                           [3]        [4]
;                                     

; Tree representation
;    (1 (2 (3 4)))
;       /    \
;      1     (2 (3 4))
;              /  \
;             2   (3 4)
;                  / \
;                 3   4