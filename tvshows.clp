

;;;wyświetlanie

(deftemplate view
   (slot question (type SYMBOL))
   (slot answer (type SYMBOL))
   (multislot valid-answers (type SYMBOL))
   (slot state (default on)))


(defrule begin
=>
(assert (view (question powitanie)
                (answer poczatek)
                 (valid-answers)
                 (state initial)
        )
))
;;;nie powinniśmy usuwać faktów bo to nie ma lecieć po sznurku
;;;jak zrobic aby preferowalo nowe reguly
;;;sprawdzac czy stara nie isnieje

(defrule jakiGatunek
?h <- (view (question ?q))
(poczatek)
(not (exists (gatunek ?)))
(not (exists (view (question ?q) (answer gatunek))))
=>
(retract ?h)
(assert (view (question jakiGatunek)
                (answer gatunek)
                 (valid-answers Sci-Fi Fantasy Horror Slipstream)
                 (state on)
        )
))

(defrule czyAntologie
?h <- (view (question ?q))
(gatunek Sci-Fi)
(not (exists (czyAnt ?)))
(not (exists (view (question ?q) (answer czyAnt))))
=>
(retract ?h)
(assert (view (question czyAntologie)
                (answer czyAnt)
                 (valid-answers Tak Nie)
                 (state on)
        )
))


(defrule czyOperaKosmiczna
?h <- (view (question ?q))
(gatunek Sci-Fi)
(czyAnt Nie)
(not (exists (opera-czy-ziemia ?)))
(not (exists (view (question ?q) (answer opera-czy-ziemia))))
=>
(retract ?h)
(assert (view (question czyOperaKosm)
                (answer opera-czy-ziemia)
                 (valid-answers SpaceOpera Ziemia)
                 (state on)
        )
))

(defrule jacyKosmici
?h <- (view (question ?q))
(opera-czy-ziemia Ziemia)
(not (exists (kosmici-sa ?)))
(not (exists (view (question ?q) (answer kosmici-sa))))
=>
(retract ?h )
(assert (view (question jacyKosmici)
                (answer kosmici-sa)
                 (valid-answers Przyjacielscy Wrodzy)
                 (state on)
        )
))

(defrule czyAnimowane
?h <- (view (question ?q))
(or (kosmici-sa Wrodzy))
(not (exists (technika ?)))
(not (exists (view (question ?q) (answer technika))))
=>
(retract ?h )
(assert (view (question czyAnimowane)
                (answer technika)
                (valid-answers Animacja Live-action)
                (state on)
        )
))

(defrule czyKomedia
?h <- (view (question ?q))
(opera-czy-ziemia SpaceOpera)
(not (exists (czyKomedia ?)))
(not (exists (view (question ?q) (answer czyKomedia))))
=>
(retract ?h )
(assert (view (question czyKomedia)
                (answer czyKomedia)
                (valid-answers Tak Nie)
                (state on)
        )
))

(defrule USczyUK
?h <- (view (question ?q))
(czyKomedia Tak)
(not (exists (kraj ?)))
(not (exists (view (question ?q) (answer kraj))))
=>
(retract ?h )
(assert (view (question USczyUK)
                (answer kraj)
                (valid-answers US UK)
                (state on)
        )
))






;;;Odpowiedzi

(defrule f-theOuterLimits
(gatunek Sci-Fi)
(czyAnt Tak)
?h <- (view (question ?q))
(not (exists (view (question ?q) (state final))))
=>
(retract ?h )
(assert (view (question f-theOuterLimits)
                 (state final)
        )
))

(defrule f-V
(gatunek Sci-Fi)
(technika Live-action)
?h <- (view (question ?q))
(not (exists (view (question ?q) (state final))))
=>
(retract ?h )
(assert (view (question f-V)
                 (state final)
        )
))

(defrule f-invaderZIM
(gatunek Sci-Fi)
(technika Animacja)
?h <- (view (question ?q))
(not (exists (view (question ?q) (state final))))
=>
(retract ?h )
(assert (view (question f-invaderZIM)
                 (state final)
        )
))

(defrule f-AlienNation
(gatunek Sci-Fi)
(kosmici-sa Przyjacielscy)
?h <- (view (question ?q))
(not (exists (view (question ?q) (state final))))
=>
(retract ?h )
(assert (view (question f-AlienNation)
                 (state final)
        )
))

(defrule f-Futurama
(gatunek Sci-Fi)
(czyKomedia Tak)
(kraj US)
?h <- (view (question ?q))
(not (exists (view (question ?q) (state final))))
=>
(retract ?h )
(assert (view (question f-Futurama)
                 (state final)
        )
))

(defrule f-RedDwarf
(gatunek Sci-Fi)
(czyKomedia Tak)
(kraj UK)
?h <- (view (question ?q))
(not (exists (view (question ?q) (state final))))
=>
(retract ?h )
(assert (view (question f-RedDwarf)
                 (state final)
        )
))