#lang racket

;1. Geben Sie einen Ausdruck an, der die Liste der Quadrierungen (x2) aller Zahlen der Liste xs berechnet.



(define xs->sqr 
    (curry map sqr)
)

(xs->sqr (range 10))

;2. Geben Sie einen Ausdruck an, der die Teilliste aller glatt durch 3 oder 7 teilbaren Zahlen von xs konstruiert.

(define (tailbar? x)
    (and 
        (< 0 x) 
        (ormap (compose 
            (curry eq? 0) 
            (curry modulo x) 
        ) 
        (list 7 3))
    )
)

(define tailbar 
    (curry filter tailbar?)
)

(tailbar (range 10))


;3. Geben Sie einen Ausdruck an, der die Summe der geraden Zahlen größer 6 in xs ermittelt.

(define (sum-of-x>6 xs) 
    (foldr + 0 (filter (curry < 6) xs))
) 

(sum-of-x>6 (range 10))

;4. Zusatzaufgabe: Geben Sie einen Ausdruck an, welcher eine Liste anhand eines Prädikats (z.B. odd?) in zwei Teillisten aufspaltet und zurückgibt.

(define (my-partition f xs) 
    (list (filter f xs) (filter (compose not f) xs))
) 

(my-partition even? (range 10))
;; or 
;; (partition even? (range 10))