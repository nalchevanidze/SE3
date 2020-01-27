#lang racket

(require se3-bib/prolog/prologInScheme)
;;1.1
;;a)

(unify '(?A + ?B + 3) '(1 + ?B + ?D) no-bindings)

(unify '(1 + ?B) '(1 + 4) no-bindings)

;;b)

(unify '(?A + 1) '(3+2 +1) no-bindings)

;;c)
(unify '(?A +1) '(3 + 2 + 1) no-bindings)

;;d)

(unify '(?A + 1) '((+ 3 2) + 1) no-bindings) 

;;e)

(unify '(1 ?B . ?REST) '(?X 2 ?B ?X) no-bindings)

;;f)

(unify  '(?X 2 ?B ?Y) '(?X 2 ?B . (1)) no-bindings)

;; 1.2

; ( schueler Name ID Lieblingsfach )
(<- (schueler "Max" 0 4)) 
(<- (schueler "Laura" 1 2))
(<- (schueler "Timo" 2 0))
(<- (schueler "Gustav" 3 0))
(<- (schueler "Marie" 4 1))

; (note SchuelerID Fach Note)"
(<- (note 1 4 2))
(<- (note 2 0 1))
(<- (note 4 3 4))
(<- (note 3 4 2))
(<- (note 4 1 1))

; (fach ID Fach)
(<- (fach 0 "Mathe"))
(<- (fach 1 "Deutsch"))
(<- (fach 2 "Englisch"))
(<- (fach 3 "Physik"))
(<- (fach 4 "Chemie"))

#|
;;1.

(?- (findall  ?r (note ?r 4 2) ?schueler))

;;2.

(?- (count ?numOfStudents (note ? 4 2) ))

;;3.
(?- (schueler ?name ? ?favTopic) (schueler ?name2 ? ?favTopic1) (= ?favTopic ?favTopic1) (!= ?name ?name2))
|#
;;4
(?- (note ?studentIDs ? ?grade) (= ?grade 4) (schueler ?name ?studentIDs ?)
    (note ?studentIDs ? ?grade) (= ?grade 5) (schueler ?name ?studentIDs ?)
(note ?studentIDs ? ?grade) (= ?grade 6) (schueler ?name ?studentIDs ?))