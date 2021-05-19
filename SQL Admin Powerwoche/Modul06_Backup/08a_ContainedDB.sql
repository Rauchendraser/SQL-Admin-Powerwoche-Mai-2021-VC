/*

Eigenständige DB

Was ist nicht in einer DB , aber brauchts ..?
Login .. Master
Job .. msdb
#tab .. tempdb


Feature, das auf dem Server per default deaktiv ist

EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

Aber auch jede DB muss , wenn sie das will, aktivieren
USE [master]
GO
ALTER DATABASE [Northwind] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO

GO


Es sind User ohne Logins möglich mit Kennwort
--Anmeldung per SQL Auth aber mit anderer STD DB

--Vorteile tempdb (Sortierung)

Nachteile: keine Replikation, kein DB Cross Abfragen
	--will aber trotzdem Crossabfragen alter database dbname set trustworty on

http://blog.fumus.de/sql-server/contained-databasedie-eigenstndige-datenbank

*/