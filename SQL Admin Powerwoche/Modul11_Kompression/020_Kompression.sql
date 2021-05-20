use northwind

set statistics io, time on

--ohne Index: Table SCAN
select * from t1 where city = 'Berlin'
--50098 Seiten


create table t3(id int identity, spx char(4100))

insert into t3
select 'XY'
GO 20000


select * from t3 where id = 100

select 20000*4=8000-- = 80MB.. aber t3 ist fast 160MB groß

--jeder DS belegt etwas mehr als die Hälfte daher 20000 Seiten

--Befehl für Auslastung der Seiten


dbcc showcontig('t3')
--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%


--Problem beseitigen:
-- Datentyp anpassen.. darf man nicht wg Anwendung
--Spalten auslagern.. darf man nicht 


1 MIO DS a 4100bytes-- 1 MIO Seiten  8 GB
1MIO a 4000  500000Seiten    4GB
1MIO 100  12500Seiten  100MB

--Kompression...

--Zeilenkompression.. gut bei viele char Feldern
			--tut die  verkleinerten DS in weniger Seiten zusammeziehen

--Seitenkompression.. zuerst Zeilenkompression
  --Algor für Kompression

 --erwartete Ergebnis

 --ohne Kompression:
 --Neustart des SQL Server: RAM 287
 --Aufruf der unkomp Tabell: RAM 465
 --Seiten: 20000      CPU.300ms..    Dauer ...2700ms


 set statistics io, time on
 select * from northwind..t3

 --nach Kompression
 --ohne Kompression:
 --Neustart des SQL Server: RAM gleich 
 --Aufruf der unkomp Tabell: RAM weniger
 --Seiten: weniger 32     CPU.mehr..141    Dauer .2200.weniger

 --Normalerweise ist Kompression: 40% bis 60%
 --mehr CPU Aufwand
 --RAM wird weniger 
 --Dauer kaum geringer

 --Kompression eigtl wegegen den anderen Tabellen
 --ideal bei selten verwendeten Tabellen








