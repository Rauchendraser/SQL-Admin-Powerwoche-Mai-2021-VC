/*
Standardgröße 8 MB für DAten und Log jeweils..
Wachstumsrate : 64MB


bis inkl SQL 2014: Datendatei 5 MB
		 Logfile : 2 MB
		 Wachstum: Datendatei um 1 MB
				   Logfile: 10%


Wir wollen IO vermeiden!!!
Ideal: wenn wir gra nicht vergrößern oder nur selten

Aber was sollen wir das reinschreiben.. Initalgrößen

Wie lange lebt die Installation=? wie groß werden die DBs in 5 jahren sein??

Das backup ist keine Grund die DAtei kleiner zu machen....
Wie sichern keine Luft wg...

Wie schnell wachsen die DBs
Wie groß werden die
Wie wird zugegriffen





*/

--TEST
create table test1 (id int identity,spx char(4100))

insert into test1
select 'XY'
GO 20000


--es sollten im Bericht Datenträgerverwendung seltenst 
---autom Vergrößerungen auftauchen


select * from northwind..orders


