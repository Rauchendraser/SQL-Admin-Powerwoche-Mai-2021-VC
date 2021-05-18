/*

Wiederherstellungsmodel
..regelt was das T sichern soll

Einfach
..wird I U D bulk rudimentär protokolliert, und dann später autom. gelöscht
..also alle commited TX...
--> Das T kann nicht mehr gesichert werden
--Wann? Wenn das V reicht..TestDBs.. oder schnell

Massenprotokolliert
..wie Einfach,, aber es wird nichts gelöscht
--> NUR DAS SICHERN DES T KÜRZT DAS T
--> WIR MÜSSEN DAS T SICHERN

Vollständig
..wie Massenprotkolliert, aber sehr genau Weiss welche DS wo gelandet sind
--> wächst stärker
--> wir können auf Sekunden restore

Wann? bei ProduktivDbs zb


Wie muss ich sichern?

Wie lange darf die DB oder Server ausfallen?

Wie groß darf der Datenverlust in Zeit sein?
.. regelt das T


Sicherungsvarianten

Vollständige Sicherung
sichert die Dateien inklusiv Pfadangabe und Größe

aber es sichert nicht die Luft mit, sondern nur die Daten
aus 100MB Datene (mit 2MB Daten) werden evtl 1,5MB Sicherung
aber beim Restore werden es wieder 100MB

es wird ein Checkpoint ausgeführt
veränderte Daten aus dem RAM in Datei wegschreiben


Transakt...Sicherung
macht Checkpoint
es merkt sich die Transaktionen bzw Anweisungen
bei Restore werden alle Anweisungen wieder ausgeführt




Differentiell..
merkt sich die geänderten "Seiten" seit der letzten V Sicherung
auch Checkpoint


Was ist also der schnellste restore?
V --> möglichst häufig das V

Wie lange dauert der Restore des 3ten T?
ca solange wie die TX bei ersten mal brauchten
--> nicht viele Ts 


! V
	T
	T
	T
	T
	 
	T
	T
	T
	T
!	 D
!	T
!	T
!	T
!	T





*/