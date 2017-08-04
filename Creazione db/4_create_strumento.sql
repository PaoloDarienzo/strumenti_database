CREATE TABLE Strumento(
id int PRIMARY KEY,
dataInserimento DATE NOT NULL DEFAULT '2017-01-01',
IPInserimento VARCHAR(15) NOT NULL DEFAULT '0.0.0.0',
nome VARCHAR(150) NOT NULL,
nPezziDisponibili int NOT NULL DEFAULT 0
	CHECK (nPezziDisponibili >= 0),
descrizione VARCHAR(2000),
peso DECIMAL (7, 3) NOT NULL DEFAULT 0 
	CHECK (peso >= 0 ),
prezzo DECIMAL (8, 2) NOT NULL DEFAULT 0
	CHECK (prezzo >= 0),
classificazione VARCHAR(15) NOT NULL
	REFERENCES Classificazione(nome)
	ON UPDATE CASCADE ON DELETE NO ACTION,
marca VARCHAR(50) NOT NULL
	REFERENCES Marca(nome)
	ON UPDATE CASCADE ON DELETE NO ACTION
);