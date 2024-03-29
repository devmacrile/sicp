(define (make-leaf symbol weight)
    (list `leaf symbol weight))

(define (leaf? object)
    (eq? (car object) `leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
    (list left
          right
          (append (symbols left) (symbols right))
          (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)))

(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)))

(define (decode bits tree)
    (define (decode-1 bits current-branch)
        (if (null? bits)
            `()
            (let ((next-branch
                    (choose-branch (car bits) current-branch)))
              (if (leaf? next-branch)
                (cons (symbol-leaf next-branch)
                      (decode-1 (cdr bits) tree))
                (decode-1 (cdr bits) next-branch)))))
    (decode-1 bits tree))

(define (choose-branch bit branch)
    (cond ((= bit 0) (left-branch branch))
          ((= bit 1) (right-branch branch))
          (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
    (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))

; Takes a list of symbol-frequency pairs (i.e. (A 4) (B 3) ...)
; and constructs an ordered set of leaves.
(define (make-leaf-set pairs)
    (if (null? pairs)
        `()
        (let ((pair (car pairs)))
            (adjoin-set (make-leaf (car pair) (cadr pair))
                        (make-leaf-set (cdr pairs))))))

(define (encode message tree)
    (if (null? message)
        `()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))


; determine if symbol is contained in given tree
(define (lookup? symbol tree)
    (define (iter symbol symbs)
        (cond ((null? symbs) #f)
            ((eq? symbol (car symbs)) #t)
            (else (iter symbol (cdr symbs)))))
    (let ((symbs (symbols tree)))
        (iter symbol symbs)))


(define (encode-symbol symbol tree)
    (define (iter symbol tree code)
        (cond ((leaf? tree)
                (if (eq? symbol (symbol-leaf tree))
                  code
                  (error "bad symbol -- ENCODE-SYMBOL" symbol)))
              ((lookup? symbol (left-branch tree))
                (iter symbol (left-branch tree) (append code (list 0))))
              ((lookup? symbol (right-branch tree))
                (iter symbol (right-branch tree) (append code (list 1))))
              (else (error "bad symbol -- ENCODE-SYMBOL" symbol))))
    (iter symbol tree `()))


(define (symbol-weight symbol tree)
    (cond ((leaf? tree) 
            (if (eq? symbol (symbol-leaf tree))
                (list (weight-leaf tree))
                (error "bad symbol -- ENCODE-SYMBOL" symbol)))
          ((lookup? symbol (left-branch tree))
            (encode-symbol symbol (left-branch tree)))
          ((lookup? symbol (right-branch tree))
            (encode-symbol symbol (right-branch tree)))
          (else (error "bad symbol -- ENCODE-SYMBOL" symbol))))

(define sample-tree
    (make-code-tree (make-leaf `A 4)
                    (make-code-tree
                        (make-leaf `B 2)
                        (make-code-tree (make-leaf `D 1)
                                        (make-leaf `C 1)))))

(define sample-message `(a d a b b c a))

(encode-symbol `A sample-tree)
(encode-symbol `E sample-tree)  ; expected error
(encode sample-message sample-tree)
