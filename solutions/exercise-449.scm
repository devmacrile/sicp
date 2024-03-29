(load "amb.scm")

(define nouns `(noun student professor cat class))

(define verbs `(verb studies lectures eats sleeps))

(define articles `(article the a))

(define prepositions `(prep for to in by with))

(define adjectives `(adjective blue pretty small friendly))

(define (parse-sentence)
  (list `sentence
	(parse-noun-phrase)
	(parse-verb-phrase)))

(define (parse-simple-noun-phrase)
  (amb (list `noun-phrase
             (parse-word articles)
	     (parse-word nouns))
       (list `noun-phrase
	     (parse-word articles)
	     (parse-word adjectives)
	     (parse-word nouns))))

(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
	 (maybe-extend (list `noun-phrase
			     noun-phrase
			     (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

(define (parse-prepositional-phrase)
  (list `prep-phrase
	(parse-word-prepositions)
	(parse-noun-phrase)))

(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
	 (maybe-extend (list `verb-phrase
			     verb-phrase
			     (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

  
(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (set! *unparsed* (cdr *unparsed*))
  (list (car word-list) (amb (cdr word-list))))

(define *unparsed* `())

(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    sent))

; call parse to generate sentences now.
