Prozessor\% Prozessorzeit Überwachung des CPU-Verbrauchs auf dem Server
Logischer Datenträger\Freie MB Überwachung des freien Speicherplatzes auf den
Datenträgern

MSSQL$Instance:Datenbanken\Größe der
Datendateien (KB) Wachstumstrend im Laufe der Zeit
Arbeitsspeicher\Seiten/s Überprüfung auf Auslagerungen, ein starker Hinweis
darauf, dass die Arbeitsspeicherressourcen eventuell
nicht ausreichen

Arbeitsspeicher\Verfügbare MB Anzeige des physischen Arbeits

Prozessor\% Prozessorzeit Die Überwachung des CPU-Verbrauchs ermöglicht
Ihnen die Ermittlung von Engpässen auf dem Server
(erkennbar an anhaltend hoher Nutzung).

Hoher Prozentwert bei der Signalwartezeit
Die Signalwartezeit ist die Zeit, die ein Arbeits-Thread
auf CPU-Zeit warten muss, nachdem andere
Wartezeiten (für Sperren, Latches usw.) beendet
wurden. Müssen Prozesse auf die CPU warten, deutet
das auf einen CPU-Engpass hin.
Signalwartezeiten können in SQL Server 2000 durch
die Ausführung von
„DBCC SQLPERF(waitstats)“ und in SQL Server 2005
durch die Abfrage von „sys.dm_os_wait_stats“
ermittelt werden.

Physischer Datenträger\Durchschnittl.
Warteschlangenlänge der Festplatte
Überprüfung auf Datenträgerengpässe: Ist der
Wert größer als 2, so besteht wahrscheinlich ein
Datenträgerengpass.

MSSQL$Instance:Puffer-Manager\Lebenserwartung
von Seiten
Die Lebenserwartung einer Seite ist die Anzahl an
Sekunden, die sie im Puffer-Cache verbleibt. Ein
niedriger Wert zeigt an, dass Seiten bereits nach
kurzem Verbleib im Cache entfernt werden, was
dessen Effektivität mindert.

MSSQL$Instance:Plan-Cache\Cache-Trefferquote Eine niedrige Cache-Trefferquote für den PlanCache bedeutet, dass Ausführungspläne nicht
wiederverwendet werden.

MSSQL$Instance:Allgemeine Statistiken\Blockierte
Prozesse
Lange Blockierungen weisen auf Ressourcenkonflikt hin


Plan Cache: Trefferquote
Jede Frage benötigt einen Ausführungsplan. Im günstigsten Fall liegt dieser bereits vor. Falls nicht, muss ein neuer Plan erstellt und kompiliert werden. Das kostet Prozessorzeit.
Falls also die Prozessorleistung sehr hoch ist, sollten sie diesen Wert und Transactions / sec untersuchen. Die Trefferquote sollte so hoch wie möglich sein.

GenerellStatitics: User Connections
Anzahl der Benutzerverbindungen

Puffer Manager: Page Life Expectancy
Seiten werden in den Speicher geladen, um die Requests der Clients schnell bedienen zu können. Die gecachten Seiten können aufgrund von zu wenig Platz zugunsten anderer Seiten aus dem Cache entfernt werden. Der Wert sollte nicht unter 300 liegen. Sonst haben Sie zu wenig Hauptspeicher

SQL Statistics: Kompilierungen /sec
Ausführungspläne bedürfen einer kompilierung und evtl auch einer Recompilierung. Diese führt zu einer höheren CPU Last. Sollte dieser Wert sich erhöhen, können Sie evtl durch paramtriesierung ihrer Abfragen eine Verbesserung erreichen.

SQL Statistics: Recompilierungen /sec
Dieser Wert steigt, sobald kompilierte Pläne durch verschiedene SET Einstellungen erneut kompiliert werden müssen.

SQL Benutzerdefinierbar: User Counter 1 (bis 10)
Ein Indikator der mir persönlich sehr gut gefällt. Übergibt man der sp_Usercounter1 eine ganze Zahl  so wird diese sofort im Systemmonitor dargestellt. SO ließe sich z.B. der Tagesumsatz im Verhältnis zur CPU oder Speicher darstellen. In Worten: Ab einem bestimmten  Umsatz proTag braucht man eine besser CPU.


