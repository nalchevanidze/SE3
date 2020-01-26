#lang racket

;;; 2 Memo-Funktionen (Bearbeitungszeit: 30 Min.)
;;;  -----------------------------------------------
;;;   Definieren Sie eine rekursive Funktion zur Berechnung der Harmonischen Reihe H(n) = 􏰀nk=1 k1 
;;;   als Memo-Funktion, die sich schon berechnete Werte in einer Tabelle merkt. Stellen Sie sicher, 
;;;   dass auch die rekursiven Aufrufe an die Memo-Funktion gehen.

(define (store table k v)
    (let 
        ([h (hash-set! table k v)])
        v
    )
)

(define (retrieve table)
    (lambda (key) 
        (hash-ref table key #f)
    ) 
)

(define table1 (make-hash))
(store table1 1 "some value")
(displayln "// store (table1 1 2):")
(displayln table1)
(displayln "// retrieve (table1 1):")
(displayln ((retrieve table1) 1))
(displayln "// retrieve (table1 2):")
(displayln ((retrieve table1) 2))

(define (memo f)
    (letrec
        (
            [table (make-hash)] 
            [ensureValue (lambda (x)
                (let ([stored ((retrieve table) x)])
                    (if stored 
                        stored 
                        (store table x (f x))
                    )
                ))
            ]
        )
        ensureValue
    )
)

;;; not memoized
(define (harmonic k) 
    (if (= k 0)
        0
        (+ 
            (/ 1 k)
            (memHarmonic (- k 1))
        ) 
    )
)

(define memHarmonic 
    (memo harmonic)
)

;; Test memo function
(map memHarmonic '(1 2 3 4 20 21 300 2 80))
