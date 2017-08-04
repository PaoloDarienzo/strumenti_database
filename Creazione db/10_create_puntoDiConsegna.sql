CREATE TABLE PuntoDiConsegna(
cliente VARCHAR(50)
	REFERENCES Cliente(mail)
	ON UPDATE CASCADE ON DELETE CASCADE,
via VARCHAR(50),
civico VARCHAR(7),
CAP CHAR(5),
citta VARCHAR(40) NOT NULL,
PRIMARY KEY (cliente, via, civico, CAP)
);