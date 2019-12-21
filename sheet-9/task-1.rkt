#lang racket

;;; 1 CLOS und generische Funktionen

;;; 1.1 Definition von Klassen (10 punkt)


;;; Definieren Sie geeignete Klassen in CLOS, um Videobeiträge etc. 
;;; repräsentieren zu können. Ein Video hat als Attribute mindestens
;;; • einen eindeutigen Schlüssel,
;;; • den Namen des Erstellers,
;;; • das Erscheinungsjahr sowie
;;; • den Titel der Veröffentlichung.

;;; Je nach Art der Veröffentlichung sind weitere Angaben nötig, um auf das
;;; Werk bezug nehmen zu können:

;;; Film: Für ein Film werden zuätzlich Angaben zur Produktionsgesellschaft,
;;; zum Regisseur, dem Genre und der Altersfreigabe benötigt.
;;; Serie: Zusätzlich zu den Filmangaben: Name der Platform, Nummer der
;;; Folge.

;;; YouTube-Video: Der Name der Kanals, Link zum Video, eventuell der Erscheinungsmonat.

;;; Erzeugen Sie Objekte für die folgende Bibliographie:

;;; 1. Disney’s Mulan (2020). Produziert von: Chris Bender. Regie: Niki Caro.
;;; Produktionsgesellschaft: Walt Disney Pictures. Genre: Abenteuer. Altersfreigabe: PG-13.
;;; Ein Beispiel für ein Film

;;; 2. Disneys Große Pause (1997). Erstellt/produziert von: Paul Germain,
;;; Joe Ansolabehere. Produktionsgesellschaft: Walt Disney Television Animation. 
;;; Genre: Dramedy. Altersfreigabe: FSK 0. Platform: ABC. Folge: 1.
;;; Ein Beispiel für eine Serie

;;; 3. Spending Over $1,000 to RENEW my Annual Pass for Walt Disney
;;; World. Erstellt von: Brayden Holness. Kanal: Mickey Views - All Things
;;; Disney News. Link: https://www.youtube.com/watch?v=TDnBjVGv5eQ.
;;; Erschienen: Juni 2019.
;;; Ein Beispiel für ein YouTube-Video


;;; 1.2 Generische Funktionen und Methoden (5pkt)

;;; Definieren Sie eine generische Funktion cite, die ein Videobeitrag-Objekt als
;;; Argument erhält und für diesen Beitrag einen String mit dem korrekten Zitat
;;; erzeugt.
;;; Implementieren Sie geeignete Methoden für die generische Funktion cite
;;; und erproben Sie diese an den obigen Beispielen.

;;; 1.3 Ergänzungsmethoden (5 Pnkt)

;;; Erläutern Sie den Begriff der Ergänzungsmethode und beschreiben Sie, 
;;; welche Möglichkeiten zur Ergänzung von generischen Funktionen durch das
;;; CLOS-Objektsystem bereitgestellt werden. 
;;; Was sind Vorteile von Ergänzungsmethoden gegenüber super-calls, wie es sie z.B. in Java gibt?
;;; Beschreiben Sie weiterhin, wie Ergänzungsmethoden in ihrer Modellierung der 
;;; Aufgabenstellung verwendet werden könnten. Wie müssten Sie das
;;; Programm umstrukturieren, um den sinnvollen Einsatz von Ergänzungsmethoden zu erlauben?