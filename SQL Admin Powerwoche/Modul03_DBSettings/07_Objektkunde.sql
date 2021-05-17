/*
Tabellen

adhoc Abfragen... Select * from tabelle

Sichten
enthalten keine Daten, sondern bestehen aus einer Abfrage
verhält sich wie eine Tabelle (I U D Rechte)

create view vdemo
as
select sp3, sp5 from tabelle where sp = 10

select * from vdemo

select * from (select sp3, sp5 from tabelle where sp = 10) vdemo

schneller: adhoc vs Sicht?  gleich schnell

Warum eine Sicht?
koplexe Abfragen zu vereinfachen
wg Rechte



Prozeduren
exec procdemo 10,'HANS'

funktioniert wie eine Windows Batchdatei
kann aus vielen versch Anweisungen bestehen

create proc gpdemo @par1 int, @par varchar(50)
as
select * from customers where customerid = @par1
delete from orders where orderid = @par2
...


adhoc .. sicht .. proc

! Proz ist schneller, weil der Plan im fixer Form vorliegt..auch nach Neustart
--Plan kann auch falsch sein, wenn die erste Abfrage einfach nicht mehr zu den Daten passt



Funktion
grundsätzlich ...MIST!

--SEEK: herauspicken
select * from kunden where kundenname like 'A%'


--hier immer ein SCAN (ein Durchsuchen von A bis Z)
--F() verwenden so gut wie nie mehr Prozessoren
select * from kunden where left(kundenname,1) = 'A'



--schnell-----------------------------------langsam----->
-- PROZ          adhoc|Sicht                F()




*/