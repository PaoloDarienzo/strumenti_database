CREATE TABLE metodoDiPagamento(
cliente VARCHAR(50)
	REFERENCES Cliente(mail)
	ON UPDATE CASCADE ON DELETE CASCADE,
nomeMetodo VARCHAR(25),
credenziali VARCHAR(15),
PRIMARY KEY(cliente, nomeMetodo, credenziali)
);