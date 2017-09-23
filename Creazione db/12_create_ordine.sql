CREATE TABLE Ordine(
id int PRIMARY KEY,
ora TIME NOT NULL DEFAULT '00:00:00',
data DATE NOT NULL DEFAULT '2017-01-01',
IPAcquirente VARCHAR(45) NOT NULL DEFAULT '0.0.0.0',
metodoDiConsegna VARCHAR(30) NOT NULL,
prezzoTotale DECIMAL(7, 3) NOT NULL
	CHECK (prezzoTotale >= 0),
carrelloutente VARCHAR(50) NOT NULL,
via VARCHAR(50),
civico VARCHAR(7),
CAP CHAR(5),
nomeMetodo VARCHAR(25),
credenziali VARCHAR(15)
);