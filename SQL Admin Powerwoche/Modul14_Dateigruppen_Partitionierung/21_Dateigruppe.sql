/*
Tabellen liegen auf Dateien

Dateigruppe: Alias für einen Datendatei
Primary--mdf.. Standard

*/

create table messddaten (id int) on 'c:\progr...\...mdf'

create table messddaten (id int) on HOT --Dateigruppen

create table messddaten (id int) ON [PRIMARY] --default

USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwhotdata', FILENAME = N'D:\_SQLDB\nwhotdata.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
TO FILEGROUP [HOT]
GO

--easy...
create table messdaten(id int) ON HOT


--und wie kriege ich eine Tabelle auf eine andere Dgruppe?

--per SSMS rechte MAus auf Tabelle entwerfen
--Achtung: TAbelle wird gelöscht und evtl alle Tabelle die eine Bez haben
--werden gesperrt



--Idee: TABA 1000   TABB 100000
--Abfrage 10 Zeilen als Ergebnis
--TABA und TABB absolut identisch 



--Part Sicht
--statt einer sehr großen Umsatztabelle viele kleinere


create table u2021(id int identity, jahr int, spx int)

create table u2020(id int identity, jahr int, spx int)

create table u2019(id int identity, jahr int, spx int)

--Naja.. die Anw muss weiter funktionieren...
--select .. Umsatz

create view Umsatz
as
select * from u2021
UNION ALL --verknpüfen der Ergebnisse und kein filtern von doppelten
select * from u2020
UNION ALL
select * from u2019

select * from umsatz

select * from umsatz where jahr = 2020

ALTER TABLE dbo.u2020 ADD CONSTRAINT
	CK_u2020 CHECK (jahr=2020)


--nicht schlecht, aber: kompliziert aufwendig
--geht INS UP DEL
--ja grunds. schon....aber es darf folgendes nicht sein
--kein identity.. Anw geht nicht mehr
--man muss ein PK erstellen: id und jahr

--Fazit.. bei Archivdaten.. aber bei Produktivdaten weniger


















