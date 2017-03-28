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


; (a)
(define (tree->list-1 tree)
    (if (null? tree)
        `()
        (append (tree->list-1 (left-branch tree))
            (cons (entry tree)
                  (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list (left-branch tree)
                          (cons (entry tree)
                                (copy-to-list (right-branch tree)
                                              result-list)))))
    (copy-to-list tree `()))

; On figs 2.16
; All produce the same in-order traversal
(tree->list-1 (make-tree 7 (make-tree 3 (make-leaf 1) (make-leaf 5)) (make-tree 9 `() (make-leaf 11))))
(tree->list-2 (make-tree 7 (make-tree 3 (make-leaf 1) (make-leaf 5)) (make-tree 9 `() (make-leaf 11))))

(tree->list-1 (make-tree 3 (make-leaf 1) (make-tree 7 (make-leaf 5) (make-tree 9 `() (make-leaf 11)))))
(tree->list-2 (make-tree 3 (make-leaf 1) (make-tree 7 (make-leaf 5) (make-tree 9 `() (make-leaf 11)))))

(tree->list-1 (make-tree 5 (make-tree 3 (make-leaf 1) `()) (make-tree 9 (make-leaf 7) (make-leaf 11))))
(tree->list-2 (make-tree 5 (make-tree 3 (make-leaf 1) `()) (make-tree 9 (make-leaf 7) (make-leaf 11))))


; (b) Same order of growth in the steps required?  
;     tree->list-1 calls append in each subproblem, which will contain ~half the nodes
;     of the tree => this is a O(log n) operation.
;     So, the first procedure is actually nlog(n) whereas the second is O(n) (i.e. cons faster than append).

