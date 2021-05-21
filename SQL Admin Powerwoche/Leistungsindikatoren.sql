Prozessor\% Prozessorzeit �berwachung des CPU-Verbrauchs auf dem Server
Logischer Datentr�ger\Freie MB �berwachung des freien Speicherplatzes auf den
Datentr�gern

MSSQL$Instance:Datenbanken\Gr��e der
Datendateien (KB) Wachstumstrend im Laufe der Zeit
Arbeitsspeicher\Seiten/s �berpr�fung auf Auslagerungen, ein starker Hinweis
darauf, dass die Arbeitsspeicherressourcen eventuell
nicht ausreichen

Arbeitsspeicher\Verf�gbare MB Anzeige des physischen Arbeits

Prozessor\% Prozessorzeit Die �berwachung des CPU-Verbrauchs erm�glicht
Ihnen die Ermittlung von Engp�ssen auf dem Server
(erkennbar an anhaltend hoher Nutzung).

Hoher Prozentwert bei der Signalwartezeit
Die Signalwartezeit ist die Zeit, die ein Arbeits-Thread
auf CPU-Zeit warten muss, nachdem andere
Wartezeiten (f�r Sperren, Latches usw.) beendet
wurden. M�ssen Prozesse auf die CPU warten, deutet
das auf einen CPU-Engpass hin.
Signalwartezeiten k�nnen in SQL Server 2000 durch
die Ausf�hrung von
�DBCC SQLPERF(waitstats)� und in SQL Server 2005
durch die Abfrage von �sys.dm_os_wait_stats�
ermittelt werden.

Physischer Datentr�ger\Durchschnittl.
Warteschlangenl�nge der Festplatte
�berpr�fung auf Datentr�gerengp�sse: Ist der
Wert gr��er als 2, so besteht wahrscheinlich ein
Datentr�gerengpass.

MSSQL$Instance:Puffer-Manager\Lebenserwartung
von Seiten
Die Lebenserwartung einer Seite ist die Anzahl an
Sekunden, die sie im Puffer-Cache verbleibt. Ein
niedriger Wert zeigt an, dass Seiten bereits nach
kurzem Verbleib im Cache entfernt werden, was
dessen Effektivit�t mindert.

MSSQL$Instance:Plan-Cache\Cache-Trefferquote Eine niedrige Cache-Trefferquote f�r den PlanCache bedeutet, dass Ausf�hrungspl�ne nicht
wiederverwendet werden.

MSSQL$Instance:Allgemeine Statistiken\Blockierte
Prozesse
Lange Blockierungen weisen auf Ressourcenkonflikt hin


Plan Cache: Trefferquote
Jede Frage ben�tigt einen Ausf�hrungsplan. Im g�nstigsten Fall liegt dieser bereits vor. Falls nicht, muss ein neuer Plan erstellt und kompiliert werden. Das kostet Prozessorzeit.
Falls also die Prozessorleistung sehr hoch ist, sollten sie diesen Wert und Transactions / sec untersuchen. Die Trefferquote sollte so hoch wie m�glich sein.

GenerellStatitics: User Connections
Anzahl der Benutzerverbindungen

Puffer Manager: Page Life Expectancy
Seiten werden in den Speicher geladen, um die Requests der Clients schnell bedienen zu k�nnen. Die gecachten Seiten k�nnen aufgrund von zu wenig Platz zugunsten anderer Seiten aus dem Cache entfernt werden. Der Wert sollte nicht unter 300 liegen. Sonst haben Sie zu wenig Hauptspeicher

SQL Statistics: Kompilierungen /sec
Ausf�hrungspl�ne bed�rfen einer kompilierung und evtl auch einer Recompilierung. Diese f�hrt zu einer h�heren CPU Last. Sollte dieser Wert sich erh�hen, k�nnen Sie evtl durch paramtriesierung ihrer Abfragen eine Verbesserung erreichen.

SQL Statistics: Recompilierungen /sec
Dieser Wert steigt, sobald kompilierte Pl�ne durch verschiedene SET Einstellungen erneut kompiliert werden m�ssen.

SQL Benutzerdefinierbar: User Counter 1 (bis 10)
Ein Indikator der mir pers�nlich sehr gut gef�llt. �bergibt man der sp_Usercounter1 eine ganze Zahl  so wird diese sofort im Systemmonitor dargestellt. SO lie�e sich z.B. der Tagesumsatz im Verh�ltnis zur CPU oder Speicher darstellen. In Worten: Ab einem bestimmten  Umsatz proTag braucht man eine besser CPU.


