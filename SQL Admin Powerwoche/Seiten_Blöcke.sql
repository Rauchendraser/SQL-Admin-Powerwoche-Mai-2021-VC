/*
Datensätze kommen in Seiten

1 Seiten ist 8192bytes groß
-hat max 700 Slots
-1 DS kann eigtl. nicht mehr als 8060 bytes haben
-von einer Seite sind nur 8072bytes nutzbar

Seiten werden immer 1:1 in RAM gelesen

Seiten sind in Blöcke organisiert
8 Seiten am Stück ergeben einen Block

Ziel: je weniger Seiten wir brauchen, desto besser



*/

create table t3 (id int, sp char(4100), sp2 char(4100))