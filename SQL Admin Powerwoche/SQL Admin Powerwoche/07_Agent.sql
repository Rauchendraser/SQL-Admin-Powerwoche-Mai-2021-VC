/*
Agent Jobs werden grundsätzlich mit Agent Konto ausgeführt

Operator
Einen Nachricht bzgl Erfolg oder Fehler geht immer 
an den Operator (Adressliste)


Aufträge sollen einen Admin bzgl Erfolg oder Fehler benachrichtigen
Benachrichtigung bei Erfolg, Fehler
ideal bei Abschluss

Dazu benötigt man ein Mailprofil

Mailprofil = SMTP Konto (inkl SMTPServer, Mailkonto)




Dem Agent muss allerdings noch erklärt werden, wie er Mails versenden soll


1) SQL Agent Eigenschaften ..Warnungssystem.. Mailprofil aktivieren
2) Agent neu starten
3) bis inkl SQL 2014 muss Agent auch noch rechte bekommen
		in der DB MSDB
		Rolle=Gruppe
		Öfftl Profil dann muss Agent in  DatabaseMailUserRole sein


USE [master]
GO
CREATE LOGIN [KAIRO\sqlAgent] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO
USE [msdb]
GO
CREATE USER [KAIRO\sqlAgent] FOR LOGIN [KAIRO\sqlAgent]
GO
USE [msdb]
GO
ALTER ROLE [DatabaseMailUserRole] ADD MEMBER [KAIRO\sqlAgent]
GO

Ab SQL 2016 nicht mehr notwendig
Datenbankemail
Gast Zugriff wird autom gewährt



WARNUNGEN
Bei best Fehlernummern oder Fehlerkategorie den Admin benachritigen
oder Auftrag ausführen...


Fehlernummer: best Fehler
Eben=Kategorie
Je höher die Ebene, desto schlimmer der Fehler

Ebene.. Schweregrade
Ebene 10
Ebene 15 DAU
Ebene 16 DAU
Ebene 14 Rechtemeldung
Ebene 17
Ebene 20
Ebene 21
Ebene 23
Ebene 25 --buch kurzfristig Urlaub lastsecond

Ebene 16
select * from testxyz



*/
select * from test

