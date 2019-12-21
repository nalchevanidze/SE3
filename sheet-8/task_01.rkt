;;; 1.  Wann ist eine Racket-Funktion eine Funktion höherer Ordnung?

;; wenn der andere function als argument bekommt


;;; 2. Welche der folgenden Funktionen sind Funktionen höherer Ordnung und warum?


;; (a) 
(define (test−vergleich x) 
    (cond   
        [(x 0 0) #f]
        [(x 11 12) #f] 
        [else #t]
    )
)

;; (b)