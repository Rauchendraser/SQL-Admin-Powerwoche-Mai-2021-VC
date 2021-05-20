/*
bis SQL 2014 inkl werden alle CPU Abfragen zugewiesen,
wenn die ABfragen eines best KOstenwert übersteigen

Maxdop =0 Alle

Seit SQL 2016 werden alle Kerne max 8 einer zugewiesen,
wenn Abfragen einen Kostenwert übersteigen

MAXDOP ANZHAL DER KERNE (MAX 8)

Kostenschwell per default: 5

Ab diesem Wert werden nicht 1 CPU sondern alle (Maxdop) zugewiesen

Kosten findet man im Plan
Tipp: Kschwellwert erhöhen 25

Tipp: Auch mal mit 50% der CPUs beginnen

Seit SQL 2016 ist es auch mögich pro DB MAXDOP zu vergeben..


Findet man im PLan einen Repartition Stream und einen Gather Stream, dann ist man oft mit weniger CPU
besser dran





*/

set statistics io, time on --Anzahl der Seiten, Dauer in ms, CPU Verbrauch in ms

select country, sum(freight) from t1
where city like '%e%'
group by country option (maxdop 2)

--50098
-- CPU-Zeit = 3562 ms, verstrichene Zeit = 559 ms.

--Pro Kern wurde unterschiedl viele Zeilen verarbeitet

--mit MAXDOP 4 .. dieselbe Zeit mit aber mit deutlich weniger CPU Aufwand (ca 60%)

--bei OLAP Kostenschwellwert: 25
--Anzahl der CPUs korrigieren