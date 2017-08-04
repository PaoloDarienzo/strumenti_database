CREATE TABLE foto(
id int PRIMARY KEY,
strumento int
	REFERENCES Strumento(id)
	ON UPDATE CASCADE ON DELETE CASCADE,
image OID
);