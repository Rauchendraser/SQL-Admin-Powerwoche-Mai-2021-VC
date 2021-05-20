/*

---2------
---8------
_______________0 bis 100--DG1
---117----
--126-----
______________101 bis 200 DG2
---219----
----1456--
______________201 bis Rest DG3


Part F()-- f(117)=2
f(23545)=3

--------------100----------------200---------------------------------------int
--    1                2                                         3


Part Schema


Tabelle ON SCHEMA (f() DG1 DG2 DG3)
--                   2!  1   2   3

Die DS liegen immer dort, wo sie sein müssen
Bei INS UP DEL werden DS evtl auch verschoben von DG zu DG


-----------x100------------200---------------(5000)--------------
  bis100          bis200             bis5000         rest

*/

--Umsetzung
--4 DGruppen bis100 bis200, bis5000 rest
--bei Dgruppen: keine führende Zahl, kein Leerzeichen
USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis100', 
FILENAME = N'D:\_SQLDB\nwbis100.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) 
TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis200', 
FILENAME = N'D:\_SQLDB\nwbis200.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) 
TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis5000', 
FILENAME = N'D:\_SQLDB\nwbis5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) 
TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwrest', 
FILENAME = N'D:\_SQLDB\nwrest.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) 
TO FILEGROUP [rest]
GO


--2. PartFunktion

create partition function fzahl(int)
as
RANGE LEFT FOR VALUES (100,200)

select $partition.fzahl(117)--2 Ergebnis nur eine Zahl... rein theoretisch 15000 Bereiche

--3. PartSchema
create partition scheme schZahl
as
partition fzahl to (bis100,bis200, rest)
---                     1    2       3


--4. Tabelle anlegen .. auf das Schema

create table ptab(id int identity, nummer int, spx char(4100)) ON schZahl(nummer)

set statistics io, time off

declare @i as int=1

while @i<=20000
	begin
		insert into ptab (nummer, spx) values (@i,'XY')
		set @i+=1
	end

	--Bringst was?
set statistics io, time on

select * from ptab where id = 100

--kein IX Vorschlag und Table Scan HEAP--besser als Scan = SEEK
--pickt sich eine Haufen raus..
select * from ptab where nummer = 100

select * from ptab where nummer = 15434--wird teurer und ineffektiv


--Neue Grenze einführen: 5000
--Tab, F(), schema

--schema, f().. nie Tabelle
--Reihenfolge: schema, dann f()

alter partition scheme schzahl next used bis5000
--bis hierhin keine Änderung

select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
from ptab group by $partition.fzahl(nummer)


----------100------------200-------------5000---------------
alter partition function fzahl() split range (5000)

select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
from ptab group by $partition.fzahl(nummer)

select * from ptab where nummer = 4100 --4800 Seiten statt 19800

--Grenze entfernen
-- nie TAB 
--Reihenfolge:F() 

---------!100------200--------------------5000-------

alter partition function fzahl() merge range(100)

--aber wo sind die Daten jetzt wirklich?

CREATE PARTITION SCHEME [schZahl] AS 
PARTITION [fzahl] TO ([bis200], [bis5000], [rest])
GO

CREATE PARTITION FUNCTION [fzahl](int) AS 
RANGE LEFT FOR VALUES (200, 5000)
GO



select * from ptab where id = 100 --immer noch 20000 Seiten
--DS ins Archiv

--Archivtabelle
create table archiv(id int not null,nummer int, spx char(4100))
ON REST


--großen Brocken ins Archiv schieben..
alter table ptab switch partition 3 to archiv

select * from ptab where nummer = 15114 --0 Seiten
select * from archiv where nummer = 15114 --15000 Seiten

--Wenn wir 100MB/Sek....
--wenn wir 1000MB DS ins Archiv: 0 sek
--weil das Archiv und die Partition auf derselben DGruppe liegen müssen
--Trick: part wird in Tabelle umbenannt

--Buchstaben
-- A bis M   N bis R   S bis Z
create partition function fzahl(varchar(50))
as
RANGE LEFT FOR VALUES ('N','S')

	          Maier?
A------------M]--------------------------------Z


--Jahreweise 
create partition function fzahl(datetime)
as
RANGE LEFT FOR VALUES ('1.1.2020','31.12.2021 23:59:59.999')

--datetime ist ungenau.. ca 2 bis 3 ms
select * from orders 
where orderdate between '1.1.1997' and '31.12.1997 23:59:59.999'


select * from orders 
where year(orderdate) = 1997

--PRIMARY
create partition scheme schZahl
as
partition fzahl to ([PRIMARY],[PRIMARY], [PRIMARY])

--besser als nicht part.. weil es sich wie kleine Tabelle verhält
--nur rein physikalisch geregtl



--Kann man best Tabelle auf Part umswitchen..?
-- dasselbe wie Tabelle auf DG legen... Aufpassen. Tabelle wird gelöscht

--Wie cool ist das denn...

select * from ptab where nummer = 3700

select * from ptab where id = 100


--ab SQL 2016 SP1 auch in Express, davor Enterprise


















