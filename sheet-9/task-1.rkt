#lang swindle

(require 
    swindle/setf 
    swindle/misc 
)

;;; 1 CLOS und generische Funktionen

;;; 1.1 Definition von Klassen (10 punkt)


;;; Definieren Sie geeignete Klassen in CLOS, um Videobeiträge etc. 
;;; repräsentieren zu können. Ein Video hat als Attribute mindestens
;;; • einen eindeutigen Schlüssel,
;;; • den Namen des Erstellers,
;;; • das Erscheinungsjahr sowie
;;; • den Titel der Veröffentlichung.

(define 
  (uniq-key name date)
  (string-append name (number->string date))
)

(defclass Video ()
    (key 
        :reader get-key
        :initarg :init-key
    )
    (name
        :reader get-name
        :initarg :init-name
    )
    (date 
        :reader get-date
        :initarg :init-date
    )
    (title 
        :reader get-title
        :initarg :init-title
    )
    :printer #t
    :documentation "video class"
)





;;; Je nach Art der Veröffentlichung sind weitere Angaben nötig, um auf das
;;; Werk bezug nehmen zu können:

;;; Film: Für ein Film werden zuätzlich Angaben zur Produktionsgesellschaft,
;;; zum Regisseur, dem Genre und der Altersfreigabe benötigt.

(defclass Film (Video)
    (produktionsgesellschaft
        :reader get-produktionsgesellschaft
        :initarg :init-produktionsgesellschaft
    )
    (regisseur
        :reader get-regisseur
        :initarg :init-regisseur
    )
    (genre
        :reader get-genre
        :initarg :init-genre
    )
    (altersfreigabe
        :reader get-altersfreigabe
        :initarg :init-altersfreigabe
    )
)



;;; Serie: Zusätzlich zu den Filmangaben: Name der Platform, Nummer der
;;; Folge.

(defclass Serie (Film) 
    (platform
        :reader get-platform
        :initarg :init-platform
    )
    (episode
        :reader get-episode
        :initarg :init-episode
    )
)


;;; YouTube-Video: Der Name der Kanals, Link zum Video, eventuell der Erscheinungsmonat.


(defclass Youtube (Video)
    (channel
        :reader get-channel
        :initarg :init-channel
    )
    (link
        :reader get-link
        :initarg :init-link
    )
    (erscheinungsmonat
        :reader get-erscheinungsmonat
        :initarg :init-erscheinungsmonat
    )
)

;;; Erzeugen Sie Objekte für die folgende Bibliographie:

;;; 1. Disney’s Mulan (2020). Produziert von: Chris Bender. Regie: Niki Caro.
;;; Produktionsgesellschaft: Walt Disney Pictures. Genre: Abenteuer. Altersfreigabe: PG-13.
;;; Ein Beispiel für ein Film

(define example-film 
    (make Film 
        :init-key (uniq-key "Disney’s Mulan" 2020 )
        :init-name "Disney’s Mulan (2020)"
        :init-date 2020
        :init-title "Disney’s Mulan"

        :init-produktionsgesellschaft "Walt Disney Pictures"
        :init-regisseur "Niki Caro"
        :init-genre "Abenteuer"
        :init-altersfreigabe "PG-13"
    )
)


;;; 2. Disneys Große Pause (1997). Erstellt/produziert von: Paul Germain,
;;; Joe Ansolabehere. Produktionsgesellschaft: Walt Disney Television Animation. 
;;; Genre: Dramedy. Altersfreigabe: FSK 0. Platform: ABC. Folge: 1.
;;; Ein Beispiel für eine Serie


(define example-serie 
    (make Serie 
        :init-key (uniq-key "Disneys Große Pause" 1997 )
        :init-name "Disneys Große Pause (1997)"
        :init-date 1997
        :init-title "Disneys Große Pause"

        :init-produktionsgesellschaft "Walt Disney Television Animation"
        :init-regisseur "Paul Germain, Joe Ansolabehere"
        :init-genre "Dramedy"
        :init-altersfreigabe "FSK 0"

        :init-platform "ABC"
        :init-episode 1
    )
)

;;; 3. Spending Over $1,000 to RENEW my Annual Pass for Walt Disney
;;; World. Erstellt von: Brayden Holness. Kanal: Mickey Views - All Things
;;; Disney News. Link: https://www.youtube.com/watch?v=TDnBjVGv5eQ.
;;; Erschienen: Juni 2019.
;;; Ein Beispiel für ein YouTube-Video

(define example-youtube 
    (make Youtube 
        :init-key (uniq-key "Spending Over $1,000 to RENEW my Annual Pass for Walt Disney" 1997 )
        :init-name "Spending Over $1,000 to RENEW my Annual Pass for Walt Disney"
        :init-date 2019
        :init-title "Spending Over $1,000 to RENEW my Annual Pass for Walt Disney"

        :init-channel "Mickey Views - All Things Disney News"
        :init-link "https://www.youtube.com/watch?v=TDnBjVGv5eQ"
        :init-erscheinungsmonat "Juni"
    )
)

(displayln example-film)
(displayln "")
(displayln example-serie)
(displayln "")
(displayln example-youtube)
(displayln "")
;;; 1.2 Generische Funktionen und Methoden (5pkt)



;;; Definieren Sie eine generische Funktion cite, die ein Videobeitrag-Objekt als
;;; Argument erhält und für diesen Beitrag einen String mit dem korrekten Zitat
;;; erzeugt.
;;; Implementieren Sie geeignete Methoden für die generische Funktion cite
;;; und erproben Sie diese an den obigen Beispielen.

(defgeneric cite ((Video))
  :combination generic-append-combination
)

(defmethod cite ((v Film))
    (list 
        (string-append 
            (get-name v) 
            ". "
            
            "Regie: "
            (get-regisseur v)
            ". "

            "Produktionsgesellschaft: "
            (get-produktionsgesellschaft  v)
            ". "

            "Genre: "
            (get-genre v)
            ". "

            "Altersfreigabe: "
            (get-altersfreigabe v)
            ". "
        )
    )
)

(defmethod cite ((v Serie))
    (list 
        (string-append 
            "Platform: "
            (get-platform v)
            ". "

            "Folge: "
            (number->string (get-episode v))
            ". "
        )
    )
)



(defmethod cite ((v Youtube))
    (list 
        (string-append 
            (get-name v) 
            ". "
            
            "Kanal: "
            (get-channel v)
            ". "

            "Link: "
            (get-link  v)
            ". "

            "Erschienen: "
            (get-erscheinungsmonat v)
            " "
            (number->string (get-date v))
        )
    )
)

;;; 3. Spending Over $1,000 to RENEW my Annual Pass for Walt Disney
;;; World. Erstellt von: Brayden Holness. Kanal: Mickey Views - All Things
;;; Disney News. Link: https://www.youtube.com/watch?v=TDnBjVGv5eQ.
;;; Erschienen: Juni 2019.
;;; Ein Beispiel für ein YouTube-Video

(displayln (cite example-film))
(displayln "")
(displayln (cite example-serie))
(displayln "")
(displayln (cite example-youtube))
(displayln "")

;;; 1.3 Ergänzungsmethoden (5 Pnkt)

;;; Erläutern Sie den Begriff der Ergänzungsmethode und beschreiben Sie, 
;;; welche Möglichkeiten zur Ergänzung von generischen Funktionen durch das
;;; CLOS-Objektsystem bereitgestellt werden. 
;;; Was sind Vorteile von Ergänzungsmethoden gegenüber super-calls, wie es sie z.B. in Java gibt?
;;; Beschreiben Sie weiterhin, wie Ergänzungsmethoden in ihrer Modellierung der 
;;; Aufgabenstellung verwendet werden könnten. Wie müssten Sie das
;;; Programm umstrukturieren, um den sinnvollen Einsatz von Ergänzungsmethoden zu erlauben?