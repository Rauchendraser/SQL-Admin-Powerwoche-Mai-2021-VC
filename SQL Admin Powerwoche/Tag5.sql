/*
Installation

tempdb
 eig HDD

 T1117  T1118
 gleich große Dateien
 Tabellen bekommen uniform extents

 soviele Dateien haben wie Kerne max 8

 Zeilenversionierung

 USE [master]
GO
ALTER DATABASE [NwindBig] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO
ALTER DATABASE [NwindBig] SET ALLOW_SNAPSHOT_ISOLATION ON
GO


--TIPP 
ab SQL 2019
ALTER DATABASE NwindBig SET ACCELERATED_DATABASE_RECOVERY = ON

deutlich schnellere Restore aus dem Logfile
deutlich schnellere Rollback bei Transactions

würde ich immer aktivieren...


Seiten Blöcken
8kb
1 DS muss in Seite passen
8 Seiten am Stück ein Block

gute Idee HDDs mit 64kb formatieren

mehr invest in mehr Logiles bringt nix: Es wird immer nur in ein Logfile geschrieben
--> Logfile auf schnellen Datenträger


Reduzierung der HDD Last

-Kompression
 40 bis 60%


-Partitionierung
	part Sicht (Archivtabelle)  umständlich
	physikal. Partitionierung
		für User transparent


Part F()
-------A-------------------100------------------2.5.2021-----------
max 15000 Bereiche


Part Schema

Tabelle-->Schema(f()--Zahl=DGR)


create partition function partf(Datentyp)
as
RANGE LEFT FOR VALUES(Gw1, Gw2,Gw3..)


create partition scheme schName
as
partition partf to (DG1,DG2,DG3)

create table tab(id int..) ON schName(sp3)


neue Grenze

alter partition scheme schName next used neueDg

alter partition function Partf split range (neuerGw)


Grenze entfernen

alter partition function partf() merge range (Gw)





















*/