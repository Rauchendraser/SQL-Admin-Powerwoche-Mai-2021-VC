Um einen Nachricht zu bekommen ob ein Auftrag ok oder mit Fehler urchief


1: ich brauchen einen Mailserver
	SMTP Zugangsdaten
	smtp.server.de  Port 25
	oder auch der lok SMTP Server 
	mailadresse@sql.local

2: Operator anlegen, 
	ein angeben der Emailadresse beim Auftrag nicht mögich ist
	als Kontaktliste

USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'NameDesOP', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'nameOp@email.de'

3: Unter Verwaltung DB Email einrichten
	Profil enthält Infos zu SMTP Zugangsdaten
	Max Größe der Email
	Öfftl. od Privates Profil

4: Dem SQL Agent unter Eigenschaften...
		Warnugssystem das Profil zuweisen

5: Agent neu starten

6: Dem Auftrag den Operator zuweisen

--bis SQL 2014

7: der SQL Agent (Dienstkonto) muss ein User in der MSDB sein 
..und Mitglied der Rolle DatabaseMailUserRole
	


---User meldet Fehler Ebene 15.. DAU 
.. Ebene 16: DAU

..User  meldet.... Ebene 24.. Urlaub einrreichen



select * from sysmessages
