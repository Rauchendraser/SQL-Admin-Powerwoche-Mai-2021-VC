/*
INDIZES


Gruppierter INDEX
Nicht gruppierter INDEX
------------------------
funktionieren beide gleich

der Unterschied ist.. Gr IX ist die Tabelle in sortierter Form
nur 1mal pro Tabelle

gut geeignet, wenn rel viel, aber vor allem bei Bereichsabfragen
immer zuerst: vergib den Gr IX zuerst!!!!!
...und dann den PK 

N GR IX ist eine Kopie der DS mit Zeigern zum Orignal
auch 1000mal pro Tabelle

wenn bei where rel wenig rauskommt
was ist relativ? 1% 50%


--fehlende Indizes ..wo ein SEEK geholfen hätte
--überflüssige Indizes.. die keier verwendet , aber aktualisert werden müssen
I U D sind erst dann fertig, wenn der IX auch stimmt


--weniger IO, weniger RAM Verbauch, schneller Abfragen, weniger CPU
--weniger Sperren

....where sp 
		=
		>
		<
		like 'A%'	
		between 
		in 

		NON SARG ---immer SCAN
		!=   
		like '%A
		<>
		

*/


select * from sys.dm_db_index_usage_stats
--index_id: 0 = HEAP  1= CL IX  >1= NON CL IX



select object_name(i.object_id) as TableName
      ,i.type_desc,i.name
      ,us.user_seeks, us.user_scans
      ,us.user_lookups,us.user_updates
      ,us.last_user_scan, us.last_user_update
  from sys.indexes as i
       left outer join sys.dm_db_index_usage_stats as us
                    on i.index_id=us.index_id
                   and i.object_id=us.object_id
 where objectproperty(i.object_id, 'IsUserTable') = 1
go



--Fehlende Indizes
select p.query_plan
   from sys.dm_exec_cached_plans
        cross apply sys.dm_exec_query_plan(plan_handle) as p
  where p.query_plan.exist(
         'declare namespace
          mi="http://schemas.microsoft.com/sqlserver/2004/07/showplan";
            //mi:MissingIndexes')=1
go


--Indizes müssen gewartet werden

Defragmentierung

0 bis 10 % nichts
> 30% Rebuild (gesamter Index Baum)
10 bis 30% Reorg (dort wo die Sprungadressen)







/*

select customerid, sum(freight) from orders where shipcountry = 'UK'
group by customerid

--wie soll ich hier Indizes vergeben

--GR IX auf: Orderdate

--zuerst: GR IX oder NGR IX
--dann das where = Schlüsselspalten
--dann das SELECT : Customerid, freight


SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.OrderDate, Orders.Freight, Orders.ShipCity, Orders.ShipCountry, 
                         [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].OrderID

INTO t1
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID

insert into t1
select * from t1
--bis wir eine Million haben, dann hören wir auf...


alter table t1 add id int identity


select * from t1 where id = 100

select * into t2 from t1

select * from t2 where city = 'London'

select * from t2 where freight = 0.02

select country, city, avg(unitprice*quantity) from t1
where freight < 2 or productid = 10
group by country , city

-- GR IX = Orderdate
--Where

--wg Statistiken. Stat  werden nu in Abst akt
--Indizes fragementieren--defragmentieren..!







*/

