(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
    (list entry left right))

(define (make-leaf entry)
    (list entry `() `()))

(define (element-of-set? x set)
    (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
            (element-of-set? x (left-branch set)))
        ((> x (entry set))
            (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
    (cond ((null? set) (make-tree x `() `()))
        ((= x (entry set)) set)
        ((< x (entry set))
            (make-tree (entry set)
                       (adjoin-set x (left-branch set))
                       (right-branch set)))
        ((> x (entry set))
            (make-tree (entry set)
                       (left-branch set)
                       (adjoin-set x (right-branch set))))))

(define (list->tree elements)
    (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
    (if (= n 0)
        (cons `() elts)
        (let ((left-size (quotient (- n 1) 2)))
            (let ((left-result (partial-tree elts left-size)))
                (let ((left-tree (car left-result))
                    (non-left-elts (cdr left-result))
                    (right-size (- n (+ left-size 1))))
                  (let ((this-entry (car non-left-elts))
                    (right-result (partial-tree (cdr non-left-elts)
                                                 right-size)))
                    (let ((right-tree (car right-result))
                        (remaining-elts (cdr right-result)))
                      (cons (make-tree this-entry left-tree right-tree)
                            remaining-elts))))))))

; (a)
; Builds the tree by building the left tree, then building the right tree
; based on the elements in place (i.e. subdividing the input elts by 2).

(list->tree (list 1 2 3 5 7 9 11))
; (5 (2 (1 () ()) (3 () ())) (9 (7 () ()) (11 () ())))
;
;         5
;       /   \
;      2     9
;     / \   / \
;    1   3 7   11

; (b)
; cons is used at each step to 'merge', so runtime is O(n)


