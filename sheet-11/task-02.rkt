#lang racket

;;; 2 Memo-Funktionen (Bearbeitungszeit: 30 Min.)
;;;  -----------------------------------------------
;;;   Definieren Sie eine rekursive Funktion zur Berechnung der Harmonischen Reihe H(n) = 􏰀nk=1 k1 
;;;   als Memo-Funktion, die sich schon berechnete Werte in einer Tabelle merkt. Stellen Sie sicher, 
;;;   dass auch die rekursiven Aufrufe an die Memo-Funktion gehen.



(define table1 (make-hash))

(define store  
    (curry hash-set!)
)

(store table1 1 "some value")
(displayln "// store (table1 1 2):")
(displayln table1)

(define (retrieve table)
    (lambda (key) 
        (hash-ref table key #f)
    ) 
)

(displayln "// retrieve (table1 1):")
(displayln ((retrieve table1) 1))
(displayln "// retrieve (table1 2):")
(displayln ((retrieve table1) 2))

(define (memo f)
    (letrec
        (
            [table (make-hash)] 
            [ensureValue (lambda (x)
                (let ([storedValue (retrieve table x)])
                    (if storedValue 
                        storedValue 
                        (store table x (f x))
                    )
                ))
            ]
        )
        ensureValue
    )
)

(define (harmonic k) 
    (if (= k 0)
        0
        (+ 
            (/ 1 k)
            (harmonic (- k 1))
        ) 
    )
)

(map harmonic '(1 2 3 4))