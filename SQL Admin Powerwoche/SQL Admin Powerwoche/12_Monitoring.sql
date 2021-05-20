/*
Aktuelles Probleme

Tools...

1. Taskmanager: bist du sicher, dass es SQL Server ist?

	mslaugh.exe  
	teakids.exe

	RAID 5 extrem viel Schreibleistung

	Locks.. Sperren

2. Aktivitätsmonitor

Alle Prozesse über 50 sind die von Usern oder Agent





Problem vorbei


*/



select * from sysprocesses

select * from sys.dm_os_wait_stats


--Abfrage-->Queue FiFo--> Worker-->Analyse-->Ressource X.......OK..........CPU---Abfrage wird verarbeitet
							--               --0               50ms       20ms

							--50+20 Wartezeit
							--signalZeit ist Anteil der CPU 20
							--Ressourcenwartezeit= GemsateZeit minus Signalzeit


--es werden hier nur kumullierete Werte angezeigt

select * from sys.dm_os_wait_stats order by 3 desc

---DMV

select * from sys.d


--Tools zum Aufzeichnen

--mit Grafik: Perfmon ..Leistungsüb

