CREATE TABLE Ordine(
id int PRIMARY KEY,
ora TIME NOT NULL DEFAULT '00:00:00',
data DATE NOT NULL DEFAULT '2017-01-01',
IPAcquirente VARCHAR(15) NOT NULL DEFAULT '0.0.0.0',
metodoDiConsegna VARCHAR(30) NOT NULL,
prezzoTotale int NOT NULL
	CHECK (prezzoTotale >= 0),
carrello VARCHAR(50)
	REFERENCES Cliente(mail)
	ON UPDATE CASCADE ON DELETE CASCADE,
clienteConsegna VARCHAR(50),
via VARCHAR(50),
civico VARCHAR(7),
CAP CHAR(5),
clientePagamento VARCHAR(50),
nomeMetodo VARCHAR(25),
credenziali VARCHAR(15),
	FOREIGN KEY (clienteConsegna, via, civico, CAP)
		REFERENCES puntoDiConsegna(cliente, via, civico, CAP)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (clientePagamento, nomeMetodo, credenziali)
		REFERENCES metodoDiPagamento(cliente, nomeMetodo, credenziali)
		ON UPDATE CASCADE ON DELETE CASCADE
);