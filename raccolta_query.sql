CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE DOMAIN livello AS VARCHAR(15)
 CHECK( VALUE IN('PRINCIPIANTE', 'INTERMEDIO', 'AVANZATO', 'ND') );

 CREATE DOMAIN tipoCliente AS VARCHAR(15)
  CHECK( VALUE IN(
  'OCCASIONALE',
  'PROFESSIONISTA',
  'TITOLARE',
  'ADMIN') );
  
  CREATE TABLE Classificazione(
nome VARCHAR(15) PRIMARY KEY
);

CREATE TABLE Marca (
	nome character varying(50) NOT NULL PRIMARY KEY
	);
	
CREATE TABLE Strumento(
id UUID PRIMARY KEY,
dataInserimento DATE NOT NULL DEFAULT '2017-01-01',
IPInserimento VARCHAR(45) NOT NULL DEFAULT '0.0.0.0',
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
	ON UPDATE CASCADE ON DELETE NO ACTION,
productType CHAR(1) NOT NULL DEFAULT 0,
usato BOOL DEFAULT false,
sconto int NOT NULL DEFAULT 0 
	CHECK (sconto >= 0 AND sconto <= 100),
nPezziMinimi int NOT NULL DEFAULT 0,
livelloConsigliato livello
);

CREATE TABLE foto(
id int PRIMARY KEY,
strumento UUID
	REFERENCES Strumento(id)
	ON UPDATE CASCADE ON DELETE CASCADE,
image OID
);

CREATE TABLE Cliente(
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

CREATE TABLE metodoDiPagamento(
cliente VARCHAR(50)
	REFERENCES Cliente(mail)
	ON UPDATE CASCADE ON DELETE CASCADE,
nomeMetodo VARCHAR(25),
credenziali VARCHAR(15),
PRIMARY KEY(cliente, nomeMetodo, credenziali)
);

CREATE TABLE Ordine(
id int,
idstrumento int,
npezzi int NOT NULL DEFAULT 0,
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
credenziali VARCHAR(15),
PRIMARY KEY (id, idstrumento)
);


INSERT INTO Marca(nome)
	VALUES	
		('Casio'),
		('Cort'),
		('DDrum'),
		('DWDrums'),
		('Eko'),
		('Epiphone'),
		('ESP'),
		('Fender'),
		('Gibson'),
		('Gretsch'),
		('Hammond'),
		('Ibanez'),
		('Korg'),
		('Mark Bass'),
		('Mavis'),
		('Meinl'),
		('Musicman'),
		('Ovation'),
		('Paiste'),
		('Pearl'),
		('Remo'),
		('Roland'),
		('Sabian'),
		('Sonor'),
		('TAMA'),
		('Warwick'),
		('Yamaha'),
		('Zildjian');
		
UPDATE Marca SET nome=upper(nome);

INSERT INTO Classificazione(nome)
	VALUES	
		('arco'),
		('fiato'),
		('percussione'),
		('tastiera'),
		('pizzico');
		
UPDATE Classificazione SET nome=upper(nome);

INSERT INTO strumento(id, datainserimento, ipinserimento, nome, npezzidisponibili, descrizione, peso, prezzo, classificazione, marca, producttype,
		usato, sconto, npezziminimi, livelloconsigliato)
	VALUES (uuid_generate_v4(), '2017-01-01', '192.168.56.1', 'KORG LP180 WH', 5, 'Da Korg un pianoforte digitale che punta a diventare uno dei migliori prodotti dell''anno per rapporto qualità-prezzo nel campo dei piano digitali, l''LP-180. Cabinet dal design sottile, suono di livello professionale, copritastiera, leggio e tre pedali. Con questo strumento Korg punta a segnare un punto a suo favore nella categoria dei pianoforti digitali entry level.',
	23.3, 666.00, 'TASTIERA', 'KORG', 'c', false, 0, 0, 'ND'),
	(uuid_generate_v4(), '2012-02-01', '192.168.56.1', 'YAMAHA P45', 25, 'Il P45 è il primo modello della nuova serie P, con un design compatto e portatile che lo rende perfetto sia per l''uso sul palco che in casa. La tastiera a 88 tasti Graded Hammer Standard con finitura opaca per i tasti neri garantisce un''eccellente suonabilità. Ci sono 10 voci stereo campionate con 64 note polifonia massima ed effetti riverbero e chorus. In modalità Dual, due voci possono essere combinate per ulteriore versatilità.',
	11.5, 493.00, 'TASTIERA', 'YAMAHA', 's', false, 19, 5, 'INTERMEDIO'),
	(uuid_generate_v4(), '2015-01-01', '192.168.56.1', 'YAMAHA DD75', 15, 'DD-75 è una batteria digitale con otto pad sensibili al tocco e due pedali. Batterie di alta qualità ed una grande varietà di suoni di percussioni provenienti da tutto il mondo sono mixate con voci d''orchestra per fornire una ampia gamma di opportunità musicali.',
	4.2, 229.00, 'TASTIERA', 'YAMAHA', 'c', false, 0, 0, 'ND'),
	(uuid_generate_v4(), '2017-11-01', '192.168.56.1', 'WARWICK RB Streamer Standard (5) Black High Polish', 1, 'Il basso elettrico Warwick Rockbass Streamer Standard è uno strumento straordinario con un corpo massello in Carolena che offre una grande varietà di suoni piacevoli e incredibile sustain. Lo Streamer standard ha un hardware di qualità, come il ponte a due pezzi che fornisce una grande action e 2 pickup humbucker MEC vintage che offrono un suono potente. Caratteristiche come la forma classica, manico in acero, tastiera in palissandro si combinano per creare un basso esteticamente gradevole e divertente da suonare.',
	2, 559, 'PIZZICO', 'WARWICK', 'p', true, 10, 0, 'ND'),
	(uuid_generate_v4(), '2016-09-01', '192.168.56.1', 'EKO CS5 Natural', 45, 'La CS 5 è una chitarra classica con body da 36'', top, fondo e fasce in Tiglio. Il manico e la tastiera sono invece in Betulla.',
	2, 54.00, 'PIZZICO', 'EKO', 's', false, 7, 10, 'INTERMEDIO'),
	(uuid_generate_v4(), '2015-01-01', '192.168.56.1', 'PEARL Roadshow RS584C/C Jet Black con Piatti e Sgabello', 4, 'Materiali di seconda categoria rendono solo la vita del batterista più difficile. Si tratta di un kit di batteria completo con tutto il necessario per iniziare il tuo viaggio ritmico verso il grande momento. Piatti, charleston e supporto del rullante dovrebbero iniziare con una base del treppiede forte e ben bilanciata. Gambe a doppia staffa e giunti di regolazione dell''inclinazione sono di vitale importanza per mantenere tutte le parti del kit ferme sotto la pressione della performance.',
	25, 499.00, 'PERCUSSIONE', 'PEARL', 'p', true, 4, 0, 'ND'),
	(uuid_generate_v4(), '2016-05-01', '192.168.56.1', 'FENDER Squier SA105 Sunburst', 10, 'Il gradito ritorno della acustica Squier è qui nel formato di altissimo livello della SA-105. Una dreadnought con un suono dolce, un grande feeling e tanto charm ad un prezzo accessibile, è dotato di un top fondo e fasce in tiglio, con tastiera e ponte in acero scuro. Altre grandi caratteristiche includono un bracing quartersawn ''X'', binding corpo-manico nero, un comodo profilo a ''C'' del manico con 20 tasti, battipenna nero strato e meccaniche cromate.',
	3.5, 99, 'PIZZICO', 'FENDER', 's', false, 10, 10, 'AVANZATO'),
	(uuid_generate_v4(), '2016-11-01', '192.168.56.1', 'IBANEZ GRX20 BKN Black Night', 2, 'Una chitarra non deve costare un sacco per suonare bene. La serie GIO è stata sviluppata per i chitarristi che vogliono la qualità Ibanez in un formato più conveniente. Non solo hanno un look migliore e suonano meglio di tutte le altre chitarre della stessa fascia di prezzo, ma il loro rigoroso controllo, il set-up e la garanzia sono le stesse di modelli Ibanez più costosi. ',
	3.5, 169, 'PIZZICO', 'IBANEZ', 'p', false, 0, 0, 'ND'),
	(uuid_generate_v4(), '2016-12-01', '192.168.56.1', 'ESP LTD M-50FR BLK', 2, 'Se sei un chitarrista agli inizi che cerca di ottenere il massimo da una chitarra ad un prezzo accesibile, la LTD M-50FR è una grande scelta. Hai l''aspetto killer senza fronzoli di una LTD M Series, progettata per i chitarristi che vogliono suonare veloce, ed un sistema di Floyd Rose Special per spettacoli pirotecnici. Il suono della M-50 è fornito da una coppia di pickup humbucker passivi ESP Designed LH-150 , manico in acero e tastiera in palissandro con 24 tasti XJ. ',
	3.5, 379, 'PIZZICO', 'ESP', 'p', true, 0, 0, 'ND'),
	(uuid_generate_v4(), '2014-07-01', '192.168.56.1', 'WARWICK Alien Standard (4) Natural', 3, 'Il WARWICK Alien Standard presenta un comodissimo cutaway di stile inusuale e una buca asimmetrica. Il top ed il body sono entrambi in laminato ed è equipaggiato con Fishman Sonitone preamp. ',
	2.8, 529, 'PIZZICO', 'WARWICK', 'p', false, 5, 0, 'ND'),
	(uuid_generate_v4(), '2017-07-01', '192.168.56.1', 'MAVIS MV1414 Serie Concerto 3/4', 5, 'Violino antichizzato con montatura in legno naturale, completo di archetto tiracantino, colofonia ed astuccio antistrappo. ',
	1.7, 159, 'ARCO', 'MAVIS', 'c', false, 0, 0, 'ND');
