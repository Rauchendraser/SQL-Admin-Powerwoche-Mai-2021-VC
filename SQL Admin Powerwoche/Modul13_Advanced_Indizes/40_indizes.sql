/*

Gr IX  clustered
nur 1* = Tabelle in immer sortierter Form
besonders geeignet bei Bereichsabfragen
> <  between



N Gr IX non Clustered
ca 1000mal pro Tabelle
ist eine Kopie best Spalten in sortierter Form
nur gut, wenn wenig rauskommt
wenig ist relativ


------------------------
eindeutigen Index
zusammengesetzter IX mehrere Spalten erzeugen den kompletten Baum
					max 16 Spalten

IX mit eingeschlossenen Spalten
			nur die Schlüsselspalte bildet den Baum
			 am Ende des Baumes findet man mehr Informationen
			 ca 1000 Spalten

gefilterter IX
		nur einen Teil in den Index-->weniger Ebenen



abdeckender IX
	--wenn ein IX alles mit Seek beantworten kann und keine Lookup braucht
    --der ideale Index


ind Sicht

partitionierter IX
rein pyhsikal Lösung für viele gefilterer Indizes
deckte aber jeden Fall ab



real hypoth IX
------------------------------
Columnstore IX (n gr / gr )



Wie beeinflusse Indizes unser System?


Abfragen mit 30 Sek Dauer plötzlich in 0 Sekunden
Abfragen deutlich länger brauchen und deutlich mehr Ressourcen verbrauchen

Sperrniveau wird gesenkt

Zeile --> Seite --> Block --> Tabelle

Ohne Index keine Zeilensperre, sondern Tabellensperren
Ausnahme: mit Part kann auch einen einz Part gesperrt

Reduzierung von IO
--> weniger RAM Verbrauch
--> weniger CPU Verbrauch

Mehr Aufwand bei vielen I U D, aber auch evtl weniger

delete from customers where customerid = 'ALFKI'










*/

SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Employees.LastName, Employees.FirstName, Orders.OrderDate, Orders.EmployeeID, 
                         Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipCountry, Orders.Freight, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, 
                         Products.UnitsInStock
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


--so oft wiederholen bis 551000 ca
insert into ku
select * from ku
--nochmal eine Kopie
select * into ku1 from ku

--jeder gute DS hat eine ID
alter table ku add id int identity




select top 10 * from ku --schnell.. schneller als Index

--Table SCAN
set statistics io, time on
select id from ku where id = 100 --65088... CPU 340   Dauer 67

--NIX_ID -- Index SEEK
select id from ku where id = 100 --3  0 CPU Dauer 0

--IX SEEK + Lookup
select id, freight from ku where id = 100 --4 Seiten


select id, freight from ku where id < 100
select id, freight from ku where id < 1000
select id, freight from ku where id < 15000 --  Table Scan
select id, freight from ku where id < 12000 --4 Seiten


--Lookup muss weg

--NIX_ID_FR zusammengesetzer eindeutiger IX
select id, freight from ku where id < 1000
select id, freight from ku where id < 15000 --  
select id, freight from ku where id < 1000000 --immer noch IX SEEK


--NIX_ID_INKL_FR
select id, freight from ku where id = 1000 
--warum immer noch den anderen, weil identisch viele Ebenen
select id, freight, lastname, firstname from ku where id = 1000 


--gefilterter Index
--hat nur einen Vorteil, wenn wir auf weniger Ebenen kommen
select id, freight, productname from ku
where
	freight< 1 and Country = 'Germany'
	#
	--zb Nach Bestelldatum des aktuelle Jahres  Filter Orderdate => 1.1.2021



select country, count(*) from ku 
group by country -- 10789  CPU-Zeit = 345 ms, verstrichene Zeit = 85 ms.



create view v1
as
select country, count(*) as Anzahl from ku 
group by country

select * from v1


alter view v1 with schemabinding
as
select country, count_big(*) as Anzahl from dbo.ku 
group by country

--ein ind Sicht ind das Ergebnis .. also hier die 21 Ergebniszeilen
--Sicht wird automatisch unterschoben
select country, count(*) as Anzahl from dbo.ku 
group by country

--Problem der Sicht:
--es muss count_big, zahlreiche Einschränkungen
--Sicht hat immer akt korrekte Ergebis... Vorsicht bei Updates

--NOCHMAL EINE kOPIE DER KU
select * into ku2 from ku

select top 3 * from ku2
--Abfrage mit where, select mit Aggregat 

select city, avg(freight) from ku
where country = 'Germany'
group by city
--bester INDEX: NIX_CY_inkl_CIFR --50ms   1250 Seiten


--GRCS IX --0ms mit so gut wie keine Seiten
select city, avg(freight) from ku2
where country = 'Germany'
group by city


--eigtl wäre ein neuer IX fällig.. nach Analysepahse quasi 0
select lastname, avg(freight) from ku2
where city = 'Berlin'
group by lastname


--KU2 hat nur 4 MB statt 400MB wie die KU
--hat 4 MB, dann kann das aber nur durch was passieren: Kompression
--zusätzlich Archivkompression +20% Kompression

---------------------------IO
-----------CPU

--
-
-------


--Wie kann ich feststellen , ob IX gut oder schlecht oder fehlt?

select * from sys.dm_db_index_usage_stats where database_id=db_id()

select * from sys.indexes

--INdexID: 1 = Gr IX   

select * from ku where shipcity = 'XXX' --alle Seiten müssen gelesen werden..65000 da Table Scan 
dbcc showcontig('ku')

--Problem: wir haben eine Spalte reingetan
--vor einfügen der Spalten waren die Seiten so gut wie voll
--ID Spalte passt aber nicht rein
--die ID wurd in andere Seiten explizit abgelegt
--14000 Seiten für die ID

select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku'),NULL,NULL, 'detailed')
--forward_record_count zusätzliche Seiten für ID
--Tabelle muss wieder schon straff physikalisch organisiert werden
--Lösung CL IX

select * from customers

insert into customers (customerid, companyname) values ('ppedv', 'XYZ')

--Wieso hast du einen HEAP?


--PK: Ziel eine Beziehung einzugehen
--    Bedingung ist DS muss eindeutig werden
--   eindeutig durch Index (gr oder nicht gruppiert)
-- beim Setzen eines PK im SSMS wird per default immer ein CL IX eindeutig generiert
-- Tipp: lege zuerst den CL IX an auf Spalten die häufig mit between < > durchsucht werden
--dann PK setzen

--         0 = HEAP
--          >1 NGr IX


--Welche INDIZES fehlen?
/*
ABC
BAC
BCA
ACB
CBA
ACA

theroetisch wären 1000 Indizes

Brent Ozar

sp_blitzIndex

*/
select * from ku where UnitsInStock =10 and Unitprice = 10

--Phänomen
select * into ku4 from ku --ku4 ohne Indizes aber id identity

set statistics io, time on
select * from ku4 where id < 1000000
select * from ku4 where id < 2

create proc gpdemo @id int
as
select * from ku4 where id < @id

gpKundenSuche 'AL'

gpKundenSuche 'A'

gpKundenSuche 


exec gpdemo 2

exec gpdemo 1000000-- im vergl doppelt so viel CPU und 1 MIo Seiten 

--der Vorteil der Proz liegt darin ,dass der Plan nur beim ersten 
--Aufruf erstellt bzw kompiliert
--und wird auch nach Neustart immer wieder genauso verwendet

dbcc freeproccache


