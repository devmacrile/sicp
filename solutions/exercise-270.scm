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

(define (successive-merge tree)
    (if (null? (cdr tree))
        (car tree)
        (successive-merge 
            (adjoin-set 
                (make-code-tree (car tree) (cadr tree))
                (cddr tree)))))

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

(define lyric-pairs (list (list `A 2) 
                     (list `BOOM 1) 
                     (list `GET 2)
                     (list `JOB 2)
                     (list `NA 16)
                     (list `SHA 3)
                     (list `YIP 9)
                     (list `WAH 1)))

(define lyric-tree (generate-huffman-tree lyric-pairs))

(encode `(Get a job) lyric-tree)
; (1 1 1 1 1 1 1 0 0 1 1 1 1 0)
(encode `(Sha na na na na na na na na) lyric-tree)
; (1 1 1 0 0 0 0 0 0 0 0 0)
(encode `(Wah yip yip yip yip yip yip yip yip yip) lyric-tree)
; (1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)
(encode `(Sha boom) lyric-tree)
; (1 1 1 0 1 1 0 1 1)

; Total bits = 14 * 2 + 12 * 2 + 23 + 9 = 84
;
; If we used a fixed length encoding, we would need three bits
; for each symbol (8 = 2^3), so the total number of bits 
; required would = (3 * 3) * 2 + (9 * 3) * 2 + (10 * 3) + (9 * 3) = 129
