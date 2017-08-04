CREATE TABLE StrumentiProfessionali(
strumento int PRIMARY KEY
	REFERENCES Strumento(id)
	ON UPDATE CASCADE ON DELETE CASCADE,
scontoPraticabile int NOT NULL DEFAULT 0 
	CHECK (scontoPraticabile >= 0 AND scontoPraticabile <= 100),
usato BOOL DEFAULT NULL
);