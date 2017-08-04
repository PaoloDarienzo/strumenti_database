CREATE TABLE StrumentiScolastici(
strumento int PRIMARY KEY
	REFERENCES Strumento(id)
	ON UPDATE CASCADE ON DELETE CASCADE,
sconto int NOT NULL DEFAULT 0 
	CHECK (sconto >= 0 AND sconto <= 100),
nPezziMinimi int NOT NULL DEFAULT 0,
livelloConsigliato livello
);