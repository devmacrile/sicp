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

(define (tree->list tree)
    (define (copy-to-list tree result-list)
        (if (null? tree)
            result-list
            (copy-to-list (left-branch tree)
                          (cons (entry tree)
                                (copy-to-list (right-branch tree)
                                              result-list)))))
    (copy-to-list tree `()))

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

; From 2.62.  Can use as is an O(n) implementation on ordered lists.
(define (intersection-setlist set1 set2)
    (if (or (null? set1) (null? set2))
        `()
        (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                   (cons x1 (intersection-setlist (cdr set1) (cdr set2))))
                  ((< x1 x2)
                    (intersection-setlist (cdr set1) set2))
                  ((< x2 x1)
                    (intersection-setlist set1 (cdr set2)))))))


(define (union-setlist set1 set2)
    (if (or (null? set1) (null? set2))
        (append set1 set2)
        (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((= x1 x2)
                (cons x1 (union-setlist (cdr set1) (cdr set2))))
            ((< x1 x2)
                (cons x1 (union-setlist (cdr set1) set2)))
            ((< x2 x1)
                (cons x2 (union-setlist set1 (cdr set2))))))))

(define (union-set set1 set2)
    (list->tree (union-setlist (tree->list set1) (tree->list set2))))

(define (intersection-set set1 set2)
    (list->tree (intersection-setlist (tree->list set1) (tree->list set2))))


(union-set (list->tree (list 1 2 3 5 7 9)) (list->tree (list 2 4 6 8)))
(intersection-set (make-tree 2 (make-leaf 1) (make-leaf 3)) (make-tree 3 (make-leaf 2) (make-leaf 4)))
