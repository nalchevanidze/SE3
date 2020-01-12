#lang racket

;;; 1. Sudoku
;;;
;;; Sudoku ist eine Gattung von Logikrätseln, in denen es darum geht, 
;;; eine bestimmte vorgegebene Menge von Zahlen durch Anwendung 
;;; von logischen Regeln zu vervollständigen. 
;;; Im klassischen Falle eine 9x9 großen Sudoku- Feldes ergeben sich
;;; folgende drei logische Regeln, nach denen ausgefüllt wer- den darf.
;;; Jede Zahl (von 1 bis 9) darf
;;;
;;; 1. in jeder Zeile nur einmal vorkommen,
;;; 2. in jeder Spalte nur einmal vorkommen und
;;; 3. in jedem Quadranten nur einmal vorkommen.
;;;
;;; Bei gut gestellten Rätseln gibt es stets eine eindeutige Lösung, 
;;; die zudem lediglich durch Anwendung der oben genannten Regeln zu bestimmen ist. 
;;; Ein Backtracking ist im Allgemeinen nicht notwendig.
;;;
;;; Ein Beispiel für ein solches Rätsel und dessen Lösung zeigt die untere Abbildung. 
;;; In dieser sind die einzelnen Quadranten jeweils durch 
;;; einen dickeren Rahmen hervorgehoben.
;;;
;;; In diesem Aufgabenzettel bauen Sie auf einer Repräsentation eines solchen Rätsels
;;; auf und werden ein Werkzeug zur Hilfe sowie zur Lösung 
;;; eines Sudoku-Rätsels programmieren. Um sich die Arbeit zu vereinfachen, 
;;; verwenden Sie bitte Funktionen höherer Ordnung wann immer dies möglich ist.

;;; 1.1 Konsistenz eines Spielzustands
;;;------------------------------------------------------
;;; Eva Lu Ator hat sich schon ein wenig mit dem Rätsel beschäftigt, 
;;; und folgende Repräsentation für den (initialen) Spielzustand entworfen. 
;;; Hierbei setzt sich auf den Datentyp Vektor, zu erkennen an der Raute vor den Zahlen. 
;;; Nullen repräsentieren noch nicht ausgefüllte Felder:
;;; 
(define spiel #( 
    0 0 0 0 0 9 0 7 0 
    0 0 0 0 8 2 0 5 0
    3 2 7 0 0 0 0 4 0
    0 1 6 0 4 0 0 0 0
    0 5 0 0 0 0 3 0 0
    0 0 0 0 9 0 7 0 0
    0 0 0 6 0 0 0 0 5
    8 0 2 0 0 0 0 0 0
    0 0 4 2 0 0 0 0 8
    )
)
;;;
;;; Helfen Sie Eva nun dabei, festzustellen, ob ein (teilweise) 
;;; gelöstes Rätsel einen konsistenten Zustand aufweist:
;;; 
;;; 

;;;     1. Definieren Sie eine Hilfsfunktion (xy->index x y) 
;;;     mit der Sie zwischen der Darstellung x= Spalte, y=Zeile 
;;;     und der Darstellung als Index in der Spielzustandsrepräsentation 
;;;     wechseln können:
;;;
;;;     ``` 
;;;     (xy−>index 0 0) --> 0 
;;;     (xy−>index 3 1) --> 12 
;;;     (xy−>index 8 8) --> 80
;;;     ```

(define (xy−>index x y) 
  (+ (* 9 x) y)
)

(display "expected: 0 is ")
(xy−>index 0 0)
(display "expected: 12 is ")
(xy−>index 3 1) 
(display "expected: 80 is ")
(xy−>index 8 8)

;;;     2. Definieren Sie drei Funktionen, die Ihnen jeweils Zugriff 
;;;     auf die Indizes der Zeilen, Spalten und Quadranten des 
;;;     Zustandsvektors geben:
;;;
;;;     ```
;;;     (zeile−>indizes 0) --> ’(0 1 2 3 4 5 6 7 8) 
;;;     (spalte−>indizes 5) --> ’(5 14 23 32 41 50 59 68 77)
;;;     (quadrant−>indizes 8) --> ’(60 61 62 69 70 71 78 79 80)
;;;     ```

;;; Int -> [Int]
(define (indexes f size index) 
  (map 
    (f index)
    (range 0 size)
  )
)

;;; Int -> [Int]
(define indexes-by 
  (curry indexes)
)

;;; Int -> [Int]
(define row->indexes
  (indexes-by (curry xy−>index))
)

;;; Int -> [Int]
(define column->indexes
  (indexes-by (curryr xy−>index))
)

;;; Int -> [Int]
(define zeile->indizes
  (row->indexes 9)
)

;;; Int -> [Int]
(define spalte−>indizes 
  (column->indexes 9)
)


;;; get column index from cell
;;; Int -> Int
(define (cell->column index) 
  (* (modulo index 3) 3)
)

;;; get row index from cell
;;; Int -> Int
(define (cell->row index) 
  (floor (/ index 3))
)

;;; Int -> Int
(define (cell->start-index index)
  (+ (* 27 (cell->row index)) (cell->column index))
)

;; test cell->column and cell->row
(displayln "cell -> column indexes ")
(map cell->column (range 0 9))
(displayln "cell -> row indexes ")
(map cell->row (range 0 9))
(displayln "cell -> start indexes of cell")
(map cell->start-index (range 0 9))

;;; Int -> Int
(define shift-cell 
  (compose (curry +) cell->start-index)
)

;;; [Int]
(define cell-0-indexes 
  (flatten
      (map 
          (compose 
            ((curryr map) (range 0 3))  
            (curry +)
          )
          (column->indexes 3 0)
      )
    )
)

(displayln "cell 0 indexes: ")
cell-0-indexes

;;; Int -> [Int]
(define (quadrant−>idx index) 
  (map
    (shift-cell index)  
    cell-0-indexes
  )
)

(displayln "(zeile->indizes 0) --> ’(0 1 2 3 4 5 6 7 8) ")
(zeile->indizes 0)

(displayln "(spalte−>indizes 5) --> ’(5 14 23 32 41 50 59 68 77) ")
(spalte−>indizes 5)

(displayln "(quadrant−>idx 8) --> ’(60 61 62 69 70 71 78 79 80) ")
(quadrant−>idx 8)

;;;     3. Definieren Sie eine Funktion, die ausgehend von einem 
;;;     Spielzustand und einer Indexmenge die Einträge des 
;;;     Spielzustands ermittelt:
;;; 
;;;     ```
;;;     ( spiel−>eintraege spiel (quadrant−>idx 8)) --> ’(0 0 5 0 0 0 0 0 8)
;;;     ```
 

(define (spiel−>eintraege spiel xs) 
  (map 
    ((curry vector-ref) spiel)
    xs
  )
)

(displayln "( spiel−>eintraege spiel (quadrant−>idx 8)) --> ’(0 0 5 0 0 0 0 0 8) ")
(spiel−>eintraege spiel (quadrant−>idx 8))

;;;     4. Definieren Sie ausgehend von einem Spielzustand Funktionen, 
;;;     die unter Anwendung der logischen Regeln prüfen, ob ein Spielzustand 
;;;     insgesamt konsistent oder gelöst ist. Beachten Sie, 
;;;     dass Nullen keinen Ein- fluss auf die Konsistenz haben!
;;;
;;;     ```
;;;     ( spiel−konsistent? spiel ) --> #t 
;;;     (spiel−geloest? spiel) −→ #f
;;;     ```
;;;
;;;

;;; 1.2 Sudoku lösen (ohne Backtracking)
;;; ------------------------------------------------------
;;; Um Sudoku-Spieler zu unterstützen, hatte Eva sich überlegt eine 
;;; Hilfestellung anzubieten, die anzeigt wo eine neue Zahl eindeutig gesetzt 
;;; werden kann. Hierbei können Sie zweischrittig vorgehen, 
;;; wie dies in (1.2.1) und (1.2.2) beschrieben ist. Anschließend 
;;; sollten Sie in der Lage sein, einen Sudoku-Löser 
;;; ohne Backtracking zu implementieren.
;;; 
;;;     1. Definieren Sie eine Funktion, die ein Spielfeld anhand 
;;;       einer Zahl annotiert. In diesem sind alle diejenigen Nullen durch 
;;;       das Symbol ’X ersetzt, die gemäß den Regeln 
;;;       nicht mehr für die entsprechende 
;;;       Zahl infrage kommen. Dies ist dann der Fall, wenn die Zeile, 
;;;       Spalte oder der Quadrant die Zahl bereits enthält.
;;;   
;;;       ```
;;;        (markiere−ausschluss spiel 5) --> 
;;;            ’#( 0 X 0 0 0 9 X 7 X 
;;;                X X X X 8 2 X 5 X
;;;                3 2 7 0 0 0 X 4 X
;;;                X 1 6 0 4 0 0 X X
;;;                X 5 X X X X 3 X X
;;;                X X X 0 9 0 7 X X
;;;                X X X 6 X X X X 5
;;;                8 X 2 0 0 0 X X X
;;;                0 X 4 2 0 0 X X 8
;;;            )
;;;       ```
;;;       Hinweis: Verwenden Sie initial vector-copy um den Spielzustand 
;;;       zu kopieren und verändern Sie ihn dann 
;;;       gezielt mithilfe von vector-set!.
;;; 
;;;
;;;     2. Ausgehend von dem annotierten Spielfeld können Sie nun
;;;       recht einfach bestimmen, wann eine Zahl eindeutig auf eine
;;;       Position gesetzt werden kann. Dies ist immer dann der Fall,
;;;       wenn es pro Zeile, Spalte oder Quadrant nur noch eine Null gibt.
;;;       Schreiben Sie eine Funktion, die eine Liste dieser Positionen für
;;;       eine Zahl zurück liefert.
;;;       
;;;       ```
;;;       (eindeutige−positionen spiel 5) --> ’(2 33 72)
;;;       ```
;;;
;;      3. Schreiben Sie eine Funktion (loese-spiel spiel), 
;;;       die mittels der bisher definierten Funktionen 
;;;       ein Sudoku ohne Backtracking löst. 
;;;       Gehen Sie dazu in jedem Schritt wie folgt vor:
         
;;;       • Ermittle die eindeutigen Positionen für alle Zahlen (range 1 10).
;;;       • Setze die Zahlen auf die ermittelten Positionen.
;;;       • Falls keine Positionen ermittelt werden konnten, 
;;;          brich ab - das Rätsel ist ohne Backtracking nicht lösbar.


;;; 1.3 Grafische Ausgabe
;;; –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
;;; Um dem Benutzer die Sicht auf die Spielzustände zu erleichtern, 
;;; bietet es sich an, eine grafische Darstellung mittels 
;;; des Pakets (require 2htdp/image) zu implementieren.
;;; 
;;;     1. Schreiben Sie eine Funktion zeichne-spiel, die einen 
;;;       Spielzustand grafisch anzeigt. Annotierte Spielfelder (siehe 1.2.2) 
;;;       sollten als leere Fel- der mit rotem Hintergrund dargestellt werden, 
;;;       nicht ausgefüllte Felder als leere Felder mit weißem 
;;;       Hintergrund dargestellt werden.
;;;       Alle anderen Spielfelder zeigen die eingetragene 
;;;       Zahl vor weißem Hintergrund.
;;;
;;;     2. Zusatzaufgabe: Schreiben Sie eine Funktion loese-spiel-grafisch, 
;;;       die für jeden Schritt das erzielte Zwischenergebnis anzeigt. 
;;;       Wenn Sie mögen. können Sie auch einen weiteren 
;;;       Parameter integrieren, der die Zwischenergebnisse 
;;;       (ähnlich zur Darstellung auf Seite 2) ausblendet. 
;;;       Zum Testen Ihrer Lösung finden Sie eine beispielhafte Abbildung 
;;;       direkt unter dieser Aufgabenstellung.