#lang racket

(require pfds/stream)


;;; 3. Stromorientierte Programmierung

;;; Beim Abzählspiel “FlipFlap” wird reihum gezählt, aber wenn eine Zahl, die durch 3 teilbar ist, 
;;; genannt werden soll, wird stattdessen “flip” gesagt. Ge- nauso wird bei durch 5 teilbaren Zahlen “flap” gesagt. 
;;; Ist eine Zahl sowohl durch 3 als auch durch 5 teilbar, so wird “flipflap” gesagt:
;;; 1, 2, flip, 4, flap, flip, 7, 8, flip, flap, 11, flip, 13, 14, flipflap, 16, 17, flip, 19 ...
;;; Definieren Sie eine Stromfunktion, die den Strom der natürlichen Zahlen erzeugt, 
;;; aber die durch 3 oder 5 teilbaren Zahlen durch die entsprechenden Symbole ersetzt.

