--Restore von Sicherungen sind eigtl nur auf höheren oder gleichen SQL Serveredition möglich
--auch von SP abhängig

--Gründe wieso der Restrore nicht klappt...

--Bist du auf den richtigen Server?

--Auf externe Ressourcen greift immer das Dienstkonto!

--welcher Dienst?
--SQL Server , wenn kein Zeitplan dahinter steckt, sonst Agent


--Alle Endungen angezeigt..?



select 1600/60 --26MB/sek --nur wg TLog Backup dauert es länger
select 1100/4  --275MB /sek


--JamesBond als User, aber kein Login....Was tun?


/*
Vergib Rechte immer an Rollen

Idee 1: ein Login JamesBond anlegen und dann das Login mit dem User mappen 
--geht nicht, weil...die SID nicht gleich sein wird

Idee 2:
JamesBond aus DB löschen
Dann nue anlegen mit USermapping und in Rolle Personalabteilung aufnehmen
Aber : neues Kennwort

Idee 3: Script für sp_help_revlogin...Auf QuellServer ausführen
Dann auf master sp_help_revlogin


Idee 4: sp_Change_users_login


*/


use whoamidb
sp_Change_users_login 'Report'

sp_Change_users_login 'Auto_fix' --generiert ein Login passend zu User 

--falls das Login fehlt
sp_Change_users_login 'Auto_fix' 'Hans', 'Hans', 'ppedv2019!'

--korrektur der SID zu einem best Login
sp_Change_users_login 'Update_one' 'Hans', 'Hans'


select * from  syslogins

use whoamiDB

select * from sysusers


select @@MICROSOFTVERSION