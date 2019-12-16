#lang racket

(require se3-bib/setkarten-module) 
(require racket/set)

;;; 3 Spieltheorie: Das Kartenspiel SET!


;;; Aufgabe:
;;; Schreiben Sie ein Racket Programm, welches erkennen kann, ob sich einem
;;; einem Spiel (bestehend aus zwölf zufällig vom Stapel gezogenen Karten) ein
;;; oder mehrere SETs befinden. Lösen Sie dazu die folgenden Teilaufgaben und
;;; verwenden Sie Funktionen höherer Ordnung oder nichtdeterministische 
;;; Funktionen, wann immer es Ihnen sinnvoll erscheint:


;;; 1. Entwerfen und implementieren Sie die Repräsentation der verfügbaren
;;; Ausprägungen einer Spielkarte, und bedenken Sie dabei bereits die
;;; folgenden Schritte (z.B. dass sich Funktionen höherer Ordnung leichter auf Listen als auf andere Strukturen anwenden lassen). 
;; Fahren Sie  anschlieÿend mit der Repräsentation einer Spielkarte fort.


(define shapes (list 'oval 'rectange 'wave))

(define colors (list 'red 'blue 'green))

(define counts (list 1 2 3))  

(define fills (list 'outline 'solid 'hatched))  

(struct card (count shape fill color) #:inspector #f) 

;;; 2. Erzeugen Sie die Menge (Liste) aller 81 Spielkarten, aus denen das
;;; Kartenspiel besteht. Achten Sie dabei auf die Wiederverwendung von definierten 
;;; Symbolen, insbesondere der Ausprägungen, die Sie in der
;;; vorigen Aufgabe implementiert haben. Schreiben sie eine Funktion, die
;;; die Karten grafisch als Bild darstellt. Hierzu können Sie die Funktion
;;; show−set−card aus dem Modul setkarten−module verwenden. Nach
;;; Installation der se3-bib können Sie es mit
;;; (require se3−bib/setkarten−module) einbinden.
;;; Die Signatur von show−set−card ist:
;;; ( def ine ( show−set−card n the−pa t te rn the−mode the−colo r )
;;; ; n : 1 , 2 , or 3
;;; ; t h e−p a t t e r n : ' waves , ' ov al , ' r e c t a n g l e
;;; ; the−mode: ' o u t l i n e , ' s o l i d , ' h a tc he d
;;; ; t h e−c o l o r : ' red , ' green , ' b l u e



(define (flatMap f)    
    (compose flatten (curry map f))
)

(define (genterateWith attr)  
    (flatMap (curryr map attr))
)

(define generateAll 
    (compose 
        (genterateWith colors)  
        (genterateWith fills) 
        (genterateWith shapes) 
        (genterateWith counts)
    )
)

(define allCards  
    (generateAll (list (curry card)))
)

allCards

(define (drawCard x) 
    (show-set-card 
        (card-count x)
        (card-shape x)
        (card-fill x)  
        (card-color x)
    )
)

(define draw-all 
    (curry map drawCard)
)

(draw-all allCards)

;;; 3. Schreiben Sie eine Funktion, die für drei Spielkarten bestimmt, ob es 
;;; sich bei diesen um ein SET handelt oder nicht. Testen sie diese Funktion
;;; mit manuell ausgewählten Karten des Spiels, die Sie im vorigen Schritt
;;; erzeugt haben. Der Funktionsaufruf könnte zum Beispiel so aussehen:
;;; ( is−a−set? ' ( ( 2 red o val hatched )
;;; (2 red r e c t a n g l e hatched )
;;; (2 red wave hatched ) ) ) −→ #t
;;; ( is−a−set? ' ( ( 2 red r e c t a n g l e o u t l i n e )
;;; (2 g r e en r e c t a n g l e o u t l i n e )
;;; (1 g r e en r e c t a n g l e s o l i d ) ) ) −→ #f

;; returns numbers of disjnctive features for each feature
(define (cards->sizes ls) 
    (map 
        (compose set-count list->set) 
        (list 
            (map card-count ls)
            (map card-shape ls)
            (map card-fill ls)
            (map card-color ls)
        )
    )
) 

(define (satisfies? size)
    (or 
        (eq? 3 size) 
        (eq? 1 size)
    )
)

(define is-a-set? 
     (compose 
        (curry andmap satisfies?)
        cards->sizes
    )
)


(is-a-set?
    (list 
        (card 3 'wave 'solid 'green)
        (card 3 'wave 'hatched 'red)
        (card 3 'wave 'hatched 'blue)
    )
)

(is-a-set?
    (list 
        (card 3 'wave 'solid 'green)
        (card 3 'wave 'outline 'red)
        (card 3 'wave 'hatched 'blue)
    )
)

;;; 4. Zusatzaufgabe: 7 ZusatzZiehen Sie aus den 81 Spielkarten zufällig zwölf Karten, wie dies auch pnkt.
;;; im realen Spiel passiert. Zeichnen sie ein Bild der zwölf Karten. Finden
;;; sie alle möglichen SETs, die in den aktuellen zwölf Karten vorkommen
;;; und geben Sie diese aus.


(define (randomIndexes size) 
    (for/list ([i (in-range size)])
        (random 0 80)
    )
)

(define (takeRandom size) 
    (map (curry list-ref allCards) (randomIndexes size))
)



(draw-all (takeRandom 12))

;;(#f #f -2147483647 -114 0 -1.0 #f #f #f 0)

