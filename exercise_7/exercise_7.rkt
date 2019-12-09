#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)
(require racket/generator)

(define FRAME_RATE 0.25)
(define CELL_SIZE 10)
(define FRAME_SIZE 31)



;;; 2.1 Modellierung des Spielzustands

;;; 5 Pnkt. Entwerfen Sie eine Datenstruktur für den Spielzustand des Spiel des Lebens.
;;; Beachten Sie hierbei die verschiedenen Operationen, die während des Spiela- blaufs an dieser 
;;; Datenstruktur durchgeführt werden müssen und begründen Sie Ihren Entwurf !

(struct cell (x y live) #:inspector #f) 

(define state  
  (list
    (cell 0 0 #f)
    (cell 0 1 #f)
    (cell 0 2 #f)
    (cell 1 0 #t)
    (cell 1 1 #t)
    (cell 1 2 #t)
    (cell 2 0 #f)
    (cell 2 1 #f)
    (cell 2 2 #f)
  )
)

;;; 2.2 Visualisierung des Spielzustands

;;; 5 Pnkt. Schreiben Sie, ausgehend von Ihrer Datenstruktur aus Aufgabe 2.1, eine
;;; Funktion,dieIhrenSpielzustandmithilfedesPakets(require 2htdp/image) in ein Bild überführt. 
;;; Für ein 30 × 30 großes Spielfeld sollten 10 × 10 Pixel große Quadrate pro Eintrag eine angemessene Größe darstellen. 
;;; Verwenden Sie als Kodierung für tote Zellen durchsichtige, 
;;; schwarz umrandete Quadrate und für lebendige Zellen schwarz ausgefüllte Quadrate.
(define (cellStyle x) 
  (if (cell-live x) 
    'solid
    'outline
  )
)    

(define (cellShape x) 
  (square CELL_SIZE (cellStyle x)  'black)
)

(define canvas 
  (square FRAME_SIZE "solid" "white") 
)

(define (worldScale x) 
  (+ (/ CELL_SIZE 2) 
    (* x CELL_SIZE)
  )
) 

(define (cellPlace c) 
  (make-posn 
    (worldScale (cell-x c)) 
    (worldScale (cell-y c))
  )
) 

(define (drawCells ls background)  
  (place-images
   (map cellShape ls) 
   (map cellPlace ls)
  background)
)

;;; 2.3 Spiellogik und Tests

;;; Um die Spiellogik abbilden zu können, benötigen Sie einige Funktionen, die
;;; aufgrund des aktuellen Spielzustands den folgenden Spielzustand ermitteln. 
;; Schreiben Sie daher Funktionen, die folgendes leisten:

;;; • eine Funktion, die für einen beliebigen Index des Spielzustands, 
;;;   z.B. (x = 20, y = 10), die Werte der 8er-Nachbarschaft ermittelt,
;;; • eine Funktion, die die Werte dieser 8er-Nachbarschaft erhält, und ge- mäß den Spielregeln den 
;;;   Folgezustand des Automaten am übergebenen Index bestimmt, sowie
;;; • eine Funktion, die einen kompletten Spielzustand gemäß der Regeln in einen neuen Spielzustand überführt.

;;; Testen Sie Ihre Funktionen mit einigen bekannten Mustern, die Zyklen im Spiel des Lebens erzeugen, 
;;; oder anderen besonderen Mustern, wie Gleitern oder Raumschiffen. 
;;; Eine Vielzahl an Beispielen finden Sie unter: https://de.wikipedia.org/wiki/Conways_Spiel_des_Lebens


(define (neighbour? a b) 
   (let*
      (
        [diffX (abs (- (cell-x a) (cell-x b))) ]
        [diffY (abs (- (cell-y a) (cell-y b))) ]
      )
      (and 
        (< diffX  2)  
        (< diffY  2) 
        (> (+ diffX diffY) 0)
      ) 
   )
) 

(define (neighbours c ls)
  (filter
     (curry neighbour? c)
     ls
  )
)

(define (liveCells ls) 
  (filter cell-live ls)
)
;;; • eine Funktion, die für einen beliebigen Index des Spielzustands, 
;;;   z.B. (x = 20, y = 10), die Werte der 8er-Nachbarschaft ermittelt,
(define (liveNeighbours c ls)
  (length (liveCells
     (neighbours c ls)
  ))
)

(define (reborn c) (cell (cell-x c) (cell-y c) #t))
(define (kill c) (cell (cell-x c) (cell-y c) #f))


;;; • eine Funktion, die die Werte dieser 8er-Nachbarschaft erhält, und ge- mäß den 
;;; Spielregeln den Folgezustand des Automaten am übergebenen Index bestimmt, sowie
(define (executeRules c ls)
  (let* 
    (
      [num (liveNeighbours c state)]
      [isLive (cell-live c)]
    )
    (cond
        [(and (not isLive) (eq? num 3)) (reborn c)]
        [(and isLive (< num 2)) (kill c)]
        [(and isLive (> num 3)) (kill c)]
        [else c]
    )
  )
)
 
;;; • eine Funktion, die einen kompletten Spielzustand gemäß der Regeln in einen neuen Spielzustand überführt.
(define (nextState ls) 
  (map 
    (curryr executeRules ls) 
    ls 
  )
) 

;; DIRTY MUTATION
(define (nextState! st) 
     (let* 
        ([ st (set! state (nextState state))])
        state
     )
)     

(define (renderScene state)
  (drawCells state canvas)
)


;;; 2.4 Simulation

;;; Machen Sie sich mit dem World/Universe-Framework vertraut. Sie finden
;;; weitere Informationen hierzu in der Racket-Hilfe. Binden Sie es schließlich
;;; mit (require 2htdp/universe) ein und simulieren Sie das Spiel des Lebens
;;; mit 4 Zustandsübergängen pro Sekunde.

;;; Verwenden Sie hierzu Ihren bisher definierten Spielzustand als Startzu-
;;; stand. Binden sie weiterhin die bisher definierten Funktionen zum Zeichnen und Übergang 
;;; eines Spielzustandes an die Methoden to-draw beziehungswei- se on-tick. 
;;; Im Anschluss erwecken Sie die Welt mit der Funktion big-bang zum Leben.

(big-bang state (to-draw renderScene) (on-tick nextState! FRAME_RATE) )


;;; 2.5 Zusatzaufgabe: Spielfeldrand

;;; Schreiben Sie geeignete Teile Ihrer Implementierung so neu, 
;;  dass statt der Annahme “tot” markierter Zellen am Rand, 
;;; eine Torus-artige Annahme vor- liegt. Am linken Rand beginnt das Spielfeld von rechts kommend, 
;;; am oberen Rand von unten und vice versa.
;;; Können Sie Unterschiede im Spielablauf für die in Aufgabe 2.3 verwen- deten Tests ausmachen? 
;;  Wenn ja, welche?