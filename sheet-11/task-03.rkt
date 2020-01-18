#lang lazy

(require racket/stream)

;;; 3. Stromorientierte Programmierung
;;; ---------------------------------------------------------------------
;;;     Beim Abzählspiel “FlipFlap” wird reihum gezählt, aber wenn eine Zahl, die durch 3 teilbar ist, 
;;;     genannt werden soll, wird stattdessen “flip” gesagt. Ge- nauso wird bei durch 5 teilbaren Zahlen “flap” gesagt. 
;;;     Ist eine Zahl sowohl durch 3 als auch durch 5 teilbar, so wird “flipflap” gesagt:
;;;     1, 2, flip, 4, flap, flip, 7, 8, flip, flap, 11, flip, 13, 14, flipflap, 16, 17, flip, 19 ...
;;;     Definieren Sie eine Stromfunktion, die den Strom der natürlichen Zahlen erzeugt, 
;;;     aber die durch 3 oder 5 teilbaren Zahlen durch die entsprechenden Symbole ersetzt.

(define (infiniteNats n)
    (cons n 
        (infiniteNats 
            (+ n 1)
        )
    )
)

(define (isDiv? x y)
    (= 0 (modulo x y))
)

(define (flipflap x)
    (cond
        [(and (isDiv? x 3) (isDiv? x 5)) "flipflap"]
        [(isDiv? x 5) "flap"]
        [(isDiv? x 3) "flip"]
        [else x]
    )
)

(flipflap 15)
(flipflap 14)
(flipflap 13)
(flipflap 12)
(flipflap 11)
(flipflap 10)

(!! (take 100 (infiniteNats 1)))

; force promises





;;; (define (head-stream stream) 
;;;     (car stream ) 
;;; )

;;; ( define (tail-stream stream )
;;;     (cond 
;;;         [( null? stream) '()]
;;;         [( null? (cdr stream)) '()]
;;;         [(pair? (cdr stream)) (cdr stream)] 
;;;         [else (force (cdr stream))]
;;;     )
;;; )

;;; (define (empty-stream? stream ) 
;;;     ( null? stream )
;;; )

;;; (define the-empty-stream '())

;;; ( define ( integers-from-n n ) 
;;;     (cons 
;;;         (delay
;;;             (integers-from-n (+ 1 n))
;;;         )
;;;     )
;;; ) 
                    
;;; ( define ab-3 ( integers-from-n 3))

;;; (define (not-divisible? x y) 
;;;     (not 
;;;         (= 0 (remainder x y))
;;;     )
;;; )

;;; ( define ( sieve stream ) 
;;;     (cons
;;;         (head-stream stream ) 
;;;             (delay
;;;                 (filter-stream
;;;                     (rcurry not-divisible? ( head-stream stream ))
;;;                     ( sieve ( tail-stream stream ) 
;;;                 ) 
;;;             ) 
;;;         ) 
;;;     ) 
;;; )

;;; (define *primes* (sieve ( integers-from-n 2 ) ))