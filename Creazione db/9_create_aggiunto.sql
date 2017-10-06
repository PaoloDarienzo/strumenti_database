CREATE TABLE Aggiunto(
strumento UUID
	REFERENCES Strumento(id)
	ON UPDATE CASCADE ON DELETE CASCADE,
cliente VARCHAR(50)
	REFERENCES Cliente(mail)
	ON UPDATE CASCADE ON DELETE CASCADE,
nPezzi int NOT NULL DEFAULT 0
	CHECK (nPezzi >= 0),
PRIMARY KEY (strumento, cliente)
);