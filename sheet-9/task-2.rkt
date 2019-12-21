#lang racket

;; 2 CLOS und Vererbung


;;; 2.1 Definition von Klassen (5 punkt)

;;; In dieser Aufgabe sollen Sie spezielle Hierarchie von Tieren modellieren.
;;; Zeichnen Sie unbedingt einen Vererbungsgraphen.
;;; Bitte modellieren Sie folgendes:


;;; 1. Definieren Sie als CLOS-Klasse eine Klasse von Tieren und spezialisieren Sie diese Klassen für unterschiedliche Lebensräume, in denen sich
;;; die Tiere bewegen:
;;; • Landtiere, die unterschieden werden können in:
;;; – Arboreal (auf Bäumen lebend)
;;; – Saxicolous (auf Steinen lebend),
;;; – Arenicolous (im Sand lebend),
;;; – Troglofauna (in Höhlen lebend).
;;; • Meerestiere und
;;; • flugfähige Lufttiere



;;; 2. Definieren Sie zudem Klassen von Tieren, die sich in unterschiedlichen
;;; Lebensräumen aufhalten:
;;; • Eine Amphibie, die sich zu Wasser und zu Land bewegt,
;;; • ein Klasse von Tieren wie Libellen, die sich auf dem Land, im
;;; Wasser oder aber (bevorzugt) in der Luft bewegen können,
;;; • ein flugfähiges Landtier, das sowohl auf dem Boden als auch in
;;; der Luft überleben kann,
;;; • ein (fantasie) Fisch, der wie Vögel fliegen kann


;;; Modellieren Sie zunächst nur die (leeren) Klassen inklusive der Vererbungshierarchie. 
;;; Modellierungen von generischen Methoden oder Slots werden explizit erst in den nächsten 
;;; beiden Aufgaben von Ihnen abgefragt.


;; 2.2 Operationen und Methodenkombination (5 punkt)


;;; Die Klasse Tier soll folgende Operationen bieten:
;;; 1. Abfrage des Lebensraumes, in dem sich das Tier bewegt,
;;; 2. Abfrage der Maximalgeschwindigkeit,
;;; 3. Abfrage der Gefährlichkeit für den Menschen,
;;; 4. Abfrage des Verbrauchs an Nahrung pro Woche und
;;; 5. Abfrage der Lebenserwartung.
;;; Spezifizieren Sie generische Funktionen als Signatur für die Operationen der
;;; Klasse Tier und diskutieren Sie, welche Methodenkombination für die 
;;; jeweilige Operation sinnvoll erscheint.



;;; 2.3 Klassenpräzedenz bei Mehrfachvererbung (10 punkt)

;;; Bearbeitungszeit: 1 Std., 10 Pnkt.
;;; Implementieren Sie wahlweise zwei der Operationen aus Aufgabenteil 2.2 auf
;;; der Klasse Tier (und allen erbenden Klassen). Um einen sinnvollen Einsatz
;;; der Operationen zu gewährleisten, erweitern Sie zudem die Klassen aus Aufgabenteil 2.1 
;;; um die nötigen Slots.
;;; Erstellen Sie mindestens je ein Exemplar eines Tieres, welches sich in
;;; unterschiedlichen Lebensräumen aufhält, und beschreiben Sie, 
;;; wie die implementierten generischen Funktionen auf diesen Exemplaren arbeiten. 
;;; Verwenden und beschreiben Sie hierzu auch den Begriff der Klassenpräzedenzliste.
;;; Warum ist diese hier unerlässlich?