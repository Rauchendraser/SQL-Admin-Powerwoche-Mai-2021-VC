/*
model:
Vorlage f�r neue DBs
create database testdb... Kopie der Model 

Muss ich die Model sichern?
Ja..eigtl schon..bei �nderungen
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
Warum nicht...Nat�rlich








msdb (DB f�r den Agent.. Jobs.. Zeitpl�ne, Mailsystem)

Muss man die msdb sichern..?
W�r nicht verkehrt...?
--kostet evtl am meisten Arbeit , wenn man kein Backup hat..






tempdb
#tab, ##tab
Zeilenversionierung evtl Stress f�r tempdb
IX Wartung
Auslagerungen

Muss man die tempdb sichern?
Nein.. macht 0,0 Sinn


Eigtl sollte die tempdb eig HDDs besitzen.. 
Trenne Daten von Log


Vergib der tempdb soviele Dateien wie Kerne , aber max 8

die TempDb bekommt ab SQL 2016 T1117 + T1118
T1117 alle DAteien bleiben gleich gro�, auch wenn nur eine autom w�chst
T1118 Uniform Extents statt gemischten Bl�cken

HDD0 1 3  5  7

HDD1 2 4  6   8


--------------
distribution (nur bei Replikation)
--------------
mssqlsystemressource (black box ist uns rel sch**egal)
--nach Neustart bei 0



TIPP:: Wartungsplan!
einmal t�glich...

*/

select * from sys.dm_os_wait_stats