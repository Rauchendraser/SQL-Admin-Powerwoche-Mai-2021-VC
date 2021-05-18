/*

Wiederherstellungsmodel
..regelt was das T sichern soll

Einfach
..wird I U D bulk rudiment�r protokolliert, und dann sp�ter autom. gel�scht
..also alle commited TX...
--> Das T kann nicht mehr gesichert werden
--Wann? Wenn das V reicht..TestDBs.. oder schnell

Massenprotokolliert
..wie Einfach,, aber es wird nichts gel�scht
--> NUR DAS SICHERN DES T K�RZT DAS T
--> WIR M�SSEN DAS T SICHERN

Vollst�ndig
..wie Massenprotokolliert, aber sehr genau Weiss welche DS wo gelandet sind
--> w�chst st�rker
--> wir k�nnen auf Sekunden restore

Wann? bei ProduktivDbs zb


Wie muss ich sichern?

Wie lange darf die DB oder Server ausfallen?

Wie gro� darf der Datenverlust in Zeit sein?
.. regelt das T


--Falls wir keinen Datenverlust haben wollen?
schafft kein Backup, sondenr nur Hochverf�gbarkeit
auch dann Hochverf�gbarkeit, wenn der Restore zu lange brauchen w�rde


Sicherungsvarianten

Vollst�ndige Sicherung
sichert die Dateien inklusiv Pfadangabe und Gr��e

aber es sichert nicht die Luft mit, sondern nur die Daten
aus 100MB Datene (mit 2MB Daten) werden evtl 1,5MB Sicherung
aber beim Restore werden es wieder 100MB

es wird ein Checkpoint ausgef�hrt
ver�nderte Daten aus dem RAM in Datei wegschreiben


Transakt...Sicherung
macht Checkpoint
es merkt sich die Transaktionen bzw Anweisungen
bei Restore werden alle Anweisungen wieder ausgef�hrt




Differentiell..
merkt sich die ge�nderten "Seiten" seit der letzten V Sicherung
auch Checkpoint


Was ist also der schnellste restore?
V --> m�glichst h�ufig das V

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

BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
	WITH NOFORMAT, NOINIT,  
	NAME = N'Vollst�ndig', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
	WITH  DIFFERENTIAL , NOFORMAT, NOINIT, 
	NAME = N'Diff', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak'
	WITH NOFORMAT, NOINIT,  
	NAME = N'TSicherung', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--V  TTT  D  TTT D TTT

/* was kann den e�gtl passieren?

Fall 1:
Stromausfall.. Das regelt die DB selber mit Hilfe des Logfiles
Auch bei Einfach kein Problem..

Fall 2:
Datei hin�ber..HDD defekt
Ausfallzeit 12:27
Letzte Backup : V D TTT 12:15
Datenverlust: 12 min

Fall 3: 
Jemand l�scht versehentlich Daten
Db unter anderen Namen wiederherstellen

Restore unter anderen DB Namen
Dateipfade und Namen evtl korrigieren
Proitkollfragment unter Optionen entfernen


Das direkte Wiederherstllen einer DB:
OPtion DB �berschreiben
Evtl Fragement deaktivieren
User von DB runterwerfen

Fall 4:
HDD komplett... bzw Server ist ein Haufen Asche..
�ber Datenbanken wiederherstellen:
evtl Pfade korrigieren

Fall 5: Restore der DB mit geringst m�glichen Datenverlust

DB (V D TTT letzte Sicherung 11:01)
n�chste Sicherung : 11:45
Problem .. um 11:17 Daten versemmelt
Akt Uhrzeit: 11:26

Idee...
1. T jetzt Sichern.. Dauert 5 min 11:31.. DB ist online 
2. Restore zum Zeitpunkt 11:16:59
  Jetzt ist der Datenverlust wie gro�: 5 min (11:26 bis 11:31)

besser so:

1. T jetzt Sichern.. Dauert 5 min 11:31.. 
	Die User d�rfen nicht auf die DB w�hrend der Sicherung

2. Restore zum Zeitpunkt 11:16:59
  Jetzt ist der Datenverlust wie gro�: 5 min (11:26 bis 11:31)

--Option Fragmentsicherung zulassen.. 
--Verbindungen schliessen
--DB �berscreiben


--Was wenn DB in Einzelbenutzermodus ist..


USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-05-18_11-43-42.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2021-05-18_11-43-42', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 12,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 27,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 28,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 29,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 30,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 31,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-05-18_11-32-34.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5
ALTER DATABASE [Northwind] SET MULTI_USER

GO


Fall 5: Ich weiss, das was gleich passieren kann


Man hat eine weitere lesbare DB

Die OrigDB hat 100GB 
D:\ (frei 1MB)
..geht..!
trotzdem wird eine 100GB Datei angelegt

Snapshot...

Man legt eine weitere DB mit einer weiteren Datei. Kein Log!
..die mdf ist aber nur eine H�lse

Seiten enthalten Datens�tze
Seiten (8 St�ck) ergeben eine Block

Seite 124 �ndert, dann nimmt SQL Server den Block
und kopiert die noch unver�nderten Seiten in den Snapshot

Alle Abfragen an denSnapshot werden entweder von der OrigDB beantwortet
oder vom Snaphot, wenn sich in den entspr Seiten was ge�ndert hat.
*/

USE master
GO


-- Create the database snapshot
CREATE DATABASE SN_Northwind1157 ON
( NAME = Northwind,
  FILENAME = 'D:\_SQLDB\SN_Northwind1157.mdf' ) -- Pfad und Dateiname der neuen DB Datei des Snapshot
AS SNAPSHOT OF northwind;
GO

--Kann man vom Snapshot Sicherungen machen
--N�.. macht kein Sinn

--Kann man mehere Snapshotsmachen?
--jupp geht...

--kann man die OrigDb normal sichern?
--ja.. klar.. w�r bl�d wenn nicht 

--kann man die OrigDB von den Sicherung restoren..?
--n�.. geht nur wenn alle SNAPSHOts gel�scht werden

--evtl Enterprisefeature


--Letzer Fall: Server weg , aber HDD da...und Backup ebenfalls

USE [master]
GO
ALTER DATABASE [KursDBX] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
EXEC master.dbo.sp_detach_db @dbname = N'KursDBX'
GO


-- DB trennen und anf�gen

USE [master]
GO
CREATE DATABASE [KursDBX] ON 
( FILENAME = N'D:\_HRDB\KursDBX.mdf' )
 FOR ATTACH
GO






















































