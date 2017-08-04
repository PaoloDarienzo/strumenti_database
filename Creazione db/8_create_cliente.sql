﻿CREATE TABLE Cliente(
mail VARCHAR(50) PRIMARY KEY,
nomeUtente VARCHAR(30) NOT NULL UNIQUE,
password CHAR(32) NOT NULL,
nome VARCHAR(30) NOT NULL,
cognome VARCHAR(30) NOT NULL,
CF VARCHAR(16) NOT NULL,
nTelefono VARCHAR(15) NOT NULL,
nCellulare VARCHAR(15),
cittaDiResidenza VARCHAR(40) NOT NULL,
tipo tipoCliente NOT NULL DEFAULT 'OCCASIONALE'
);