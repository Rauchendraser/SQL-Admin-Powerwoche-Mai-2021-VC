/*
1. Login für Max und Evi

2. Max und Evi sollten auf die DB Northwind zugreifen dürfen

3. Max immer nur mit IT Tabellen Evi dagegene mit MA Tabellen


*/

--1.
USE [master]
GO
CREATE LOGIN [MAX] WITH PASSWORD=N'123', 
	DEFAULT_DATABASE=[Northwind], 
	CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


USE [master]
GO
CREATE LOGIN [EVI] WITH PASSWORD=N'123', 
	DEFAULT_DATABASE=[Northwind], 
	CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE [Northwind]
GO

CREATE USER [MAX] FOR LOGIN [MAX] WITH DEFAULT_SCHEMA=[dbo]
GO

USE [Northwind]
GO

CREATE USER [EVI] FOR LOGIN [EVI] WITH DEFAULT_SCHEMA=[dbo]
GO

--3 Evi nur in MA und Max nur in IT
USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

USE [Northwind]
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO


--Neue Tabellen für MA und IT

create table IT.Projekte(itpro int)
create table IT.Mitarbeiter(itmit int)

create table MA.Projekte(MApro int)
create table MA.Mitarbeiter(MAmit int)


select * from customers

select * from projekte --error

select * from it.projekte

--Recht alle Tabellen, Sichten in Schema X lesen

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [MAX]
GO

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [EVI]
GO


--Evi soll alle Projekttabellen lesen können

use [Northwind]
GO
GRANT SELECT ON [IT].[Projekte] TO [EVI]
GO


USE [Northwind]
GO
ALTER USER [MAX] WITH DEFAULT_SCHEMA=[IT]
GO


USE [Northwind]
GO
ALTER USER [EVI] WITH DEFAULT_SCHEMA=[MA]
GO


use [Northwind]
GO
GRANT CREATE TABLE TO [EVI]
GO


use [Northwind]
GO
GRANT ALTER ON SCHEMA::[MA] TO [EVI]
GO

--Günstigerweise immer dem dbo den Besitz geben..
-- er hätte soweiso die rechte.. und es gibt keine Seiteneffekte



--Gruppe = Rolle

USE [Northwind]
GO
CREATE ROLE [ITRolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [MAX]
GO

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [ITRolle]
GO


USE [master]
GO
CREATE LOGIN [Peter] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Peter] FOR LOGIN [Peter]
GO
USE [Northwind]
GO
ALTER USER [Peter] WITH DEFAULT_SCHEMA=[IT]
GO
USE [Northwind]
GO
ALTER ROLE [ITRolle] ADD MEMBER [Peter]
GO



--MAX

select * from IT.projekte

select * from it.Mitarbeiter

select * from projekte


select * from it.projekte





create view it.viewX
as
select * from it.projekte

select * from it.viewX







select * from dbo.employees

create view Ang
as
select * from dbo.employees

--> IT.Ang  dbo
--> Obj Employees dbo

--Anforderung: Max soll Info zu Ang, aber kein Gehalt kein GebDat, keine Rel
create view it.AngList
as
select Firstname, Lastname from employees where country = 'UK'

select * from it.AngList

--Also aufpassen: nur best Personen drüfen Objekte anlegen, mit denen sich Infos aus Tabellen lesen lassen
--Proc, Sichten, F()




