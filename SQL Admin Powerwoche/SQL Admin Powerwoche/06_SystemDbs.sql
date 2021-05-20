/*
model:
Vorlage für neue DBs
create database testdb... Kopie der Model 

Muss ich die Model sichern?
Ja..eigtl schon..bei Änderungen
--besser Scripte erstellen

USE [model]
GO
DBCC SHRINKFILE (N'modellog' , 8)
GO


master
Login (nicht gleich User)
Databases
Kunfiguration/Settings

Muss man die DB sichern?
Warum nicht...Natürlich








msdb (DB für den Agent.. Jobs.. Zeitpläne, Mailsystem)

Muss man die msdb sichern..?
Wär nicht verkehrt...?
--kostet evtl am meisten Arbeit , wenn man kein Backup hat..






tempdb
#tab, ##tab
Zeilenversionierung evtl Stress für tempdb
IX Wartung
Auslagerungen

Muss man die tempdb sichern?
Nein.. macht 0,0 Sinn





--------------
distribution (nur bei Replikation)
--------------
mssqlsystemressource (black box ist uns rel sch**egal)
--nach Neustart bei 0



TIPP:: Wartungsplan!
einmal täglich...

*/

select * from sys.dm_os_wait_stats