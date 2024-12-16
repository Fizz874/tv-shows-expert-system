;;;wyświetlanie

(deftemplate view
   (slot question (type SYMBOL))
   (multislot valid-answers (type SYMBOL))
   (slot state (default on)))


(defrule begin
=>
(assert (view (question powitanie)
                 (valid-answers)
                 (state initial)
        )
))

(defrule rJakiGatunek
?h <- (view (question ?))
(powitanie)
(not (exists (jakiGatunek ?)))
(not (exists (view (question jakiGatunek))))
=>
(retract ?h)
(assert (view (question jakiGatunek)
                 (valid-answers Sci-Fi Fantasy Horror Slipstream)
                 (state on)
        )
))

(defrule rCzyAntologie
?h <- (view (question ?))
(or (jakiGatunek Sci-Fi) (wampiryCzyZombie Zadne))
(not (exists (czyAntologie ?)))
(not (exists (view (question czyAntologie))))
=>
(retract ?h)
(assert (view (question czyAntologie)
                 (valid-answers Nie Tak)
                 (state on)
        )
))


(defrule rCzyOperaKosmiczna
?h <- (view (question ?))
(jakiGatunek Sci-Fi)
(czyAntologie Nie)
(not (exists (operaCzyZiemia ?)))
(not (exists (view (question operaCzyZiemia))))
=>
(retract ?h)
(assert (view (question operaCzyZiemia)
                 (valid-answers SpaceOpera Ziemia)
                 (state on)
        )
))

(defrule rJacyKosmici
?h <- (view (question ?))
(operaCzyZiemia Ziemia)
(not (exists (jacyKosmici ?)))
(not (exists (view (question jacyKosmici))))
=>
(retract ?h )
(assert (view (question jacyKosmici)
                 (valid-answers Przyjacielscy Wrodzy)
                 (state on)
        )
))

(defrule rLiveCzyAnimacja
?h <- (view (question ?))
(or (jacyKosmici Wrodzy)
(mityCzyLegendy Legendy)
(czySuperbohater Tak))
(not (exists (liveCzyAnimacja ?)))
(not (exists (view (question liveCzyAnimacja))))
=>
(retract ?h)
(assert (view (question liveCzyAnimacja)
                (valid-answers Animacja Live-action)
                (state on)
        )
))

(defrule rCzyKomedia
?h <- (view (question ?))
(operaCzyZiemia SpaceOpera)
(not (exists (czyKomedia ?)))
(not (exists (view (question czyKomedia))))
=>
(retract ?h )
(assert (view (question czyKomedia)
                (valid-answers Nie Tak)
                (state on)
        )
))

(defrule rUSczyUK
?h <- (view (question ?))
(or (czyKomedia Tak)
(czyPortaleCzasPrzestrzen Tak)
(SFWczyNSFW NSFW))
(not (exists (USczyUK ?)))
(not (exists (view (question USczyUK))))
=>
(retract ?h)
(assert (view (question USczyUK)
                (valid-answers US UK)
                (state on)
        )
))

(defrule rCzyFanStarTreka
?h <- (view (question ?))
(czyKomedia Nie)
(jakiGatunek Sci-Fi)
(not (exists (czyFanStarTreka ?)))
(not (exists (view (question czyFanStarTreka))))
=>
(retract ?h )
(assert (view (question czyFanStarTreka)
                (valid-answers Nie Tak TakAleObejrzane)
                (state on)
        )
))


(defrule rOpiniaWilWheaton
?h <- (view (question ?))
(czyFanStarTreka Tak)
(jakiGatunek Sci-Fi)
(not (exists (opiniaWilWheaton ?)))
(not (exists (view (question opiniaWilWheaton))))
=>
(retract ?h )
(assert (view (question opiniaWilWheaton)
                (valid-answers Super Niee)
                (state on)
        )
))

(defrule rJakieStudia
?h <- (view (question ?))
(czyFanStarTreka Tak)
(opiniaWilWheaton Niee)
(not (exists (jakieStudia ?)))
(not (exists (view (question jakieStudia))))
=>
(retract ?h )
(assert (view (question jakieStudia)
                (valid-answers Politologia Socjologia Historia Emancypacja )
                (state on)
        )
))


(defrule rCzyWesterny
?h <- (view (question ?))
(czyFanStarTreka Nie)
(not (exists (czyWesterny ?)))
(not (exists (view (question czyWesterny))))
=>
(retract ?h )
(assert (view (question czyWesterny)
                (valid-answers Nie Tak)
                (state on)
        )
))

(defrule rCzyPortaleCzasPrzestrzen
?h <- (view (question ?))
(czyWesterny Nie)
(not (exists (czyPortaleCzasPrzestrzen ?)))
(not (exists (view (question czyPortaleCzasPrzestrzen))))
=>
(retract ?h )
(assert (view (question czyPortaleCzasPrzestrzen)
                (valid-answers Nie Tak)
                (state on)
        )
))

(defrule rKlasykCzyModern
?h <- (view (question ?))
(czyPortaleCzasPrzestrzen Nie)
(not (exists (klasykCzyModern ?)))
(not (exists (view (question klasykCzyModern))))
=>
(retract ?h )
(assert (view (question klasykCzyModern)
                (valid-answers Klasyk Modern)
                (state on)
        )
))


(defrule rAkcjaCzyDramat
?h <- (view (question ?))
(jakiGatunek Slipstream)
(not (exists (akcjaCzyDramat ?)))
(not (exists (view (question akcjaCzyDramat))))
=>
(retract ?h )
(assert (view (question akcjaCzyDramat)
                (valid-answers Akcja Dramat)
                (state on)
        )
))


(defrule rSteamCzyBiopunk
?h <- (view (question ?))
(jakiGatunek Slipstream)
(akcjaCzyDramat Akcja)
(not (exists (steamCzyBiopunk ?)))
(not (exists (view (question steamCzyBiopunk))))
=>
(retract ?h )
(assert (view (question steamCzyBiopunk)
                (valid-answers Steampunk Biopunk)
                (state on)
        )
))


(defrule rWhedonCzyCameron
?h <- (view (question ?))
(jakiGatunek Slipstream)
(steamCzyBiopunk Biopunk)
(not (exists (whedonCzyCameron ?)))
(not (exists (view (question whedonCzyCameron))))
=>
(retract ?h )
(assert (view (question whedonCzyCameron)
                (valid-answers Whedon Cameron)
                (state on)
        )
))


(defrule rWidzialesZArchiwumX
?h <- (view (question ?))
(jakiGatunek Slipstream)
(akcjaCzyDramat Dramat)
(not (exists (widzialesZArchiwumX ?)))
(not (exists (view (question widzialesZArchiwumX))))
=>
(retract ?h )
(assert (view (question widzialesZArchiwumX)
                (valid-answers Nie Tak TakAleZaluje)
                (state on)
        )
))

(defrule rCzyLubiszZawod
?h <- (view (question ?))
(jakiGatunek Slipstream)
(widzialesZArchiwumX TakAleZaluje)
(not (exists (czyLubiszZawod ?)))
(not (exists (view (question czyLubiszZawod))))
=>
(retract ?h )
(assert (view (question czyLubiszZawod)
                (valid-answers Nie Tak)
                (state on)
        )
))


(defrule rOpiniaScottBakula
?h <- (view (question ?))
(jakiGatunek Slipstream)
(czyLubiszZawod Nie)
(not (exists (opiniaScottBakula ?)))
(not (exists (view (question opiniaScottBakula))))
=>
(retract ?h )
(assert (view (question opiniaScottBakula)
                (valid-answers nieZnam jestemFanem)
                (state on)
        )
))

(defrule rWampiryCzyZombie
?h <- (view (question ?))
(jakiGatunek Horror)
(not (exists (wampiryCzyZombie ?)))
(not (exists (view (question wampiryCzyZombie))))
=>
(retract ?h)
(assert (view (question wampiryCzyZombie)
		(valid-answers Wampiry Zombie Zadne)
		(state on)
	)
))

(defrule rPsychoCzyKrwawe
?h <- (view (question ?))
(wampiryCzyZombie Zadne)
(czyAntologie Tak)
(not (exists (psychoCzyKrwawe ?)))
(not (exists (view (question psychoCzyKrwawe))))
=>
(retract ?h)
(assert (view (question psychoCzyKrwawe)
		(valid-answers Psycho Krwawe)
		(state on)
	)
))

(defrule rJakiWiek
?h <- (view (question ?))
(wampiryCzyZombie Wampiry)
(not (exists (jakiWiek ?)))
(not (exists (view (question jakiWiek))))
=>
(retract ?h)
(assert (view (question jakiWiek)
		(valid-answers Ponad16 Ponizej16)
		(state on)
	)
))

(defrule rSFWczyNSFW
?h <- (view (question ?))
(jakiWiek Ponad16)
(not (exists (SFWczyNSFW ?)))
(not (exists (view (question SFWczyNSFW))))
=>
(retract ?h)
(assert (view (question SFWczyNSFW)
		(valid-answers SFW NSFW)
		(state on)
	)
))

(defrule rWidzialesBuffy
?h <- (view (question ?))
(SFWczyNSFW SFW)
(not (exists (widzialesBuffy ?)))
(not (exists (view (question widzialesBuffy))))
=>
(retract ?h)
(assert (view (question widzialesBuffy)
		(valid-answers Tak Nie)
		(state on)
	)
))

(defrule rMiastoCzyHistoria
?h <- (view (question ?))
(jakiGatunek Fantasy)
(not (exists (miastoCzyHistoria ?)))
(not (exists (view (question miastoCzyHistoria))))
=>
(retract ?h)
(assert (view (question miastoCzyHistoria)
		(valid-answers Miasto Historyczne)
		(state on)
	)
))

(defrule rMityCzyLegendy
?h <- (view (question ?))
(miastoCzyHistoria Historyczne)
(not (exists (mityCzyLegendy ?)))
(not (exists (view (question mityCzyLegendy))))
=>
(retract ?h)
(assert (view (question mityCzyLegendy)
		(valid-answers Mity Legendy)
		(state on)
	)
))

(defrule rMaszGameboya
?h <- (view (question ?))
(liveCzyAnimacja Animacja)
(mityCzyLegendy Legendy)
(not (exists (maszGameboya ?)))
(not (exists (view (question maszGameboya))))
=>
(retract ?h)
(assert (view (question maszGameboya)
		(valid-answers Tak Nie)
		(state on)
	)
))

(defrule rCzyNagosc
?h <- (view (question ?))
(liveCzyAnimacja Live-action)
(mityCzyLegendy Legendy)
(not (exists (czyNagosc ?)))
(not (exists (view (question czyNagosc))))
=>
(retract ?h)
(assert (view (question czyNagosc)
		(valid-answers Tak Nie)
		(state on)
	)
))

(defrule rFaceciCzyDziewczyny
?h <- (view (question ?))
(mityCzyLegendy Mity)
(not (exists (faceciCzyDziewczyny ?)))
(not (exists (view (question faceciCzyDziewczyny))))
=>
(retract ?h)
(assert (view (question faceciCzyDziewczyny)
		(valid-answers Faceci Dziewczyny)
		(state on)
	)
))

(defrule rCzySuperbohater
?h <- (view (question ?))
(miastoCzyHistoria Miasto)
(not (exists (czySuperbohater ?)))
(not (exists (view (question czySuperbohater))))
=>
(retract ?h)
(assert (view (question czySuperbohater)
		(valid-answers Tak Nie)
		(state on)
	)
))

(defrule rCzyMitologia
?h <- (view (question ?))
(czySuperbohater Nie)
(not (exists (czyMitologia ?)))
(not (exists (view (question czyMitologia))))
=>
(retract ?h)
(assert (view (question czyMitologia)
		(valid-answers Tak Nie)
		(state on)
	)
))


;;;Odpowiedzi

(defrule f-theOuterLimits
(jakiGatunek Sci-Fi)
(czyAntologie Tak)
?h <- (view (question ?q))
(not (exists (view (question ?q) (state final))))
=>
(retract ?h )
(assert (view (question f-theOuterLimits)
                 (state final)
        )
))

(defrule f-V
(jakiGatunek Sci-Fi)
(liveCzyAnimacja Live-action)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-V)
                 (state final)
        )
))

(defrule f-invaderZIM
(jakiGatunek Sci-Fi)
(liveCzyAnimacja Animacja)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-invaderZIM)
                 (state final)
        )
))

(defrule f-AlienNation
(jakiGatunek Sci-Fi)
(jacyKosmici Przyjacielscy)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-AlienNation)
                 (state final)
        )
))

(defrule f-Futurama
(jakiGatunek Sci-Fi)
(czyKomedia Tak)
(USczyUK US)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-Futurama)
                 (state final)
        )
))

(defrule f-RedDwarf
(jakiGatunek Sci-Fi)
(czyKomedia Tak)
(USczyUK UK)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-RedDwarf)
                 (state final)
        )
))

(defrule f-EarthFinalConflict
(jakiGatunek Sci-Fi)
(czyKomedia Nie)
(czyFanStarTreka TakAleObejrzane)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-EarthFinalConflict)
                 (state final)
        )
))

(defrule f-StarTrekTheNextGeneration
(jakiGatunek Sci-Fi)
(czyFanStarTreka Tak)
(opiniaWilWheaton Super)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-StarTrekTheNextGeneration)
                 (state final)
        )
))

(defrule f-StarTrekDeepSpaceNine
(jakiGatunek Sci-Fi)
(opiniaWilWheaton Niee)
(jakieStudia Politologia)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-StarTrekDeepSpaceNine)
                 (state final)
        )
))

(defrule f-StarTrekVoyager
(jakiGatunek Sci-Fi)
(opiniaWilWheaton Niee)
(jakieStudia Emancypacja)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-StarTrekVoyager)
                 (state final)
        )
))

(defrule f-StarTrekTheOriginalSeries
(jakiGatunek Sci-Fi)
(opiniaWilWheaton Niee)
(jakieStudia Socjologia)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-StarTrekTheOriginalSeries)
                 (state final)
        )
))

(defrule f-StarTrekEnterprise
(jakiGatunek Sci-Fi)
(opiniaWilWheaton Niee)
(jakieStudia Historia)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-StarTrekEnterprise)
                 (state final)
        )
))

(defrule f-Firefly
(jakiGatunek Sci-Fi)
(czyWesterny Tak)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-Firefly)
                 (state final)
        )
))


(defrule f-StargateSG-1
(jakiGatunek Sci-Fi)
(czyPortaleCzasPrzestrzen Tak)
(USczyUK US)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-StargateSG-1)
                 (state final)
        )
))

(defrule f-DoktorWho
(jakiGatunek Sci-Fi)
(czyPortaleCzasPrzestrzen Tak)
(USczyUK UK)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-DoktorWho)
                 (state final)
        )
))

(defrule f-BattleStartGalactica1978
(jakiGatunek Sci-Fi)
(czyPortaleCzasPrzestrzen Nie)
(klasykCzyModern Klasyk)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-BattleStartGalactica1978)
                 (state final)
        )
))


(defrule f-BattleStartGalactica1978
(jakiGatunek Sci-Fi)
(czyPortaleCzasPrzestrzen Nie)
(klasykCzyModern Klasyk)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-BattleStartGalactica1978)
                 (state final)
        )
))

(defrule f-BattleStartGalactica2004
(jakiGatunek Sci-Fi)
(czyPortaleCzasPrzestrzen Nie)
(klasykCzyModern Modern)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-BattleStartGalactica2004)
                 (state final)
        )
))

(defrule f-Sanctuary
(jakiGatunek Slipstream)
(steamCzyBiopunk Steampunk)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-Sanctuary)
                 (state final)
        )
))

(defrule f-DarkAngel
(jakiGatunek Slipstream)
(whedonCzyCameron Cameron)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-DarkAngel)
                 (state final)
        )
))

(defrule f-Dollhouse
(jakiGatunek Slipstream)
(whedonCzyCameron Whedon)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-Dollhouse)
                 (state final)
        )
))


(defrule f-Fringe
(jakiGatunek Slipstream)
(widzialesZArchiwumX Tak)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-Fringe)
                 (state final)
        )
))

(defrule f-TheXFiles
(jakiGatunek Slipstream)
(widzialesZArchiwumX Nie)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-TheXFiles)
                 (state final)
        )
))

(defrule f-Lost
(jakiGatunek Slipstream)
(czyLubiszZawod Tak)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-Lost)
                 (state final)
        )
))

(defrule f-QuantumLeap
(jakiGatunek Slipstream)
(opiniaScottBakula jestemFanem)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-QuantumLeap)
                 (state final)
        )
))

(defrule f-Warehouse13
(jakiGatunek Slipstream)
(opiniaScottBakula nieZnam)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h )
(assert (view (question f-Warehouse13)
                 (state final)
        )
))


(defrule f-theWalkingDead
(wampiryCzyZombie Zombie)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-theWalkingDead)
		(state final)
	)
))

(defrule f-Charmed
(jakiGatunek Horror)
(czyAntologie Nie)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-Charmed)
		(state final)
	)
))

(defrule f-theTwilightZone
(psychoCzyKrwawe Psycho)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-theTwilightZone)
		(state final)
	)
))

(defrule f-TalesFromTheCrypt
(psychoCzyKrwawe Krwawe)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-TalesFromTheCrypt)
		(state final)
	)
))

(defrule f-Angel
(widzialesBuffy Tak)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-Angel)
		(state final)
	)
))

(defrule f-BuffyTheVampireSlayer
(widzialesBuffy Nie)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-BuffyTheVampireSlayer)
		(state final)
	)
))

(defrule f-TrueBlood
(jakiGatunek Horror)
(USczyUK US)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-TrueBlood)
		(state final)
	)
))

(defrule f-BeingHuman
(jakiGatunek Horror)
(USczyUK UK)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-BeingHuman)
		(state final)
	)
))

(defrule f-theVampireDiaries
(jakiWiek Ponizej16)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-theVampireDiaries)
		(state final)
	)
))

(defrule f-PokemonIndigoLeague
(maszGameboya Tak)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-PokemonIndigoLeague)
		(state final)
	)
))

(defrule f-AvatarTheLastAirbender
(maszGameboya Nie)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-AvatarTheLastAirbender)
		(state final)
	)
))

(defrule f-LegendOfTheSeeker
(czyNagosc Nie)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-LegendOfTheSeeker)
		(state final)
	)
))

(defrule f-SpartacusBloodAndSand
(czyNagosc Tak)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-SpartacusBloodAndSand)
		(state final)
	)
))

(defrule f-HerculesTheLegendaryJourneys
(faceciCzyDziewczyny Faceci)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-HerculesTheLegendaryJourneys)
		(state final)
	)
))

(defrule f-XenaWarriorPrincess
(faceciCzyDziewczyny Dziewczyny)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-XenaWarriorPrincess)
		(state final)
	)
))

(defrule f-theDresdenFiles
(czyMitologia Nie)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-theDresdenFiles)
		(state final)
	)
))

(defrule f-Highlander
(czyMitologia Tak)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-Highlander)
		(state final)
	)
))

(defrule f-Smallville
(czySuperbohater Tak)
(liveCzyAnimacja Live-action)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-Smallville)
		(state final)
	)
))

(defrule f-theTick
(czySuperbohater Tak)
(liveCzyAnimacja Animacja)
?h <- (view (question ?))
(not (exists (view (state final))))
=>
(retract ?h)
(assert (view (question f-theTick)
		(state final)
	)
))


