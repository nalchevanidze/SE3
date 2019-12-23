#lang swindle

(require 
    swindle/setf 
    swindle/misc 
)

;; 2 CLOS und Vererbung


(defclass Tier ()
    :printer #t
    :documentation "Tier"
)

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

;; -- Oberclassen
(defclass Landtiere (Tier)
    (speed-land
        :reader get-speed-land
        :initarg :init-speed-land
    )
    :documentation "auf Land lebend"
)


(defclass Meerestiere (Tier)
    (speed-water
        :reader get-speed-water
        :initarg :init-speed-water
    )
    ::documentation "in Meer lebend"
)

(defclass Lufttiere (Tier)
    (speed-air
        :reader get-speed-air
        :initarg :init-speed-air
    )
    ::documentation "flugfähige tiere"
)

;; -- Landtiere/**
(defclass Arboreal (Landtiere)
    (speed-tree
        :reader get-speed-tree
        :initarg :init-speed-tree
    )
    :documentation "auf Bäumen lebend"
)

(defclass Saxicolous (Landtiere)
    :documentation "auf Steinen lebend"
)

(defclass Arenicolous (Landtiere)
    (speed-sand
        :reader get-speed-sand
        :initarg :init-speed-sand
    )
    :documentation "im Sand lebend"
)

(defclass Troglofauna (Landtiere)
    :documentation "in Höhlen lebend"
)

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


(defclass Amphibie (Landtiere Meerestiere)
    :documentation "die sich zu Wasser und zu Land bewegt"
)

(defclass Hybridtier (Landtiere Meerestiere Lufttiere)
    :documentation "die sich auf dem Land, im Wasser oder aber (bevorzugt) in der Luft bewegen können"
)

(defclass Fuftlandtier (Landtiere Lufttiere)
    :documentation "ein flugfähiges Landtier, das sowohl auf dem Boden als auch in der Luft überleben kann"
)

(defclass Goldfish (Meerestiere Lufttiere)
    :documentation "ein (fantasie) Fisch, der wie Vögel fliegen kann."
)


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



(defgeneric habitat ((Tier))  
  ;; weil wir alle lebensräume brauchen
  :combination generic-append-combination
)

(defgeneric max-speed ((Tier))  
  ;; nimt die maximale gschwiendeigkeit von unterschiedliche bedingugnen
  :combination generic-max-combination
)

(defgeneric danger-level ((Tier))  
  ;; Gefährlichkeit in jedem bedingugnen
  :combination generic-append-combination
)


(defgeneric food-consumption ((Tier))  
  ;; pessimistische schätzung von nahrungsverbrauchts
  :combination generic-max-combination
)

(defgeneric life-expectancy ((Tier))  
  ;; pessimistische schätzung von Lebenserwartung
  :combination generic-min-combination
)

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


(defmethod habitat ((v Landtiere))
    (list "Land")
)

(defmethod habitat ((v Meerestiere)) 
    (list "Wasser")
)

(defmethod habitat ((v Lufttiere)) 
    (list "Luft")
)

(defmethod habitat ((v Arboreal))
    (list "Bäumen")
)

(defmethod habitat ((v Saxicolous))
    (list "Steinen")
)

(defmethod habitat ((v Arenicolous))
    (list "Sand")
)

(defmethod habitat ((v Troglofauna))
    (list "Höehle")
)

;; MAX_SPEED

(defmethod max-speed ((v Landtiere))
    (get-speed-land v)
)

(defmethod max-speed ((v Lufttiere))
    (get-speed-air v)
)

(defmethod max-speed ((v Meerestiere))
    (get-speed-water v)
)


(defmethod max-speed ((v Arboreal))
    (get-speed-tree v)
)

(defmethod max-speed ((v Saxicolous))
    (get-speed-land v)
)

(defmethod max-speed ((v Arenicolous))
    (get-speed-sand v)
)

(defmethod max-speed ((v Troglofauna))
    (get-speed-land v)
)


(define example-hybridtier 
    (make Hybridtier
        :init-speed-land  10
        :init-speed-water 15
        :init-speed-air   50
    )
)

(displayln (habitat example-hybridtier))
(displayln (max-speed example-hybridtier))



(define example-monkey 
    (make Arboreal
        :init-speed-land  10
        :init-speed-tree  15
    )
)

(displayln (habitat example-monkey))
(displayln (max-speed example-monkey))