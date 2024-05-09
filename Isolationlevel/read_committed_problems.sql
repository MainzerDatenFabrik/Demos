--READ COMMITED --
SELECT CASE transaction_isolation_level 
    WHEN 0 THEN 'Unspecified' 
    WHEN 1 THEN 'ReadUncommitted' 
    WHEN 2 THEN 'ReadCommitted' 
    WHEN 3 THEN 'Repeatable' 
    WHEN 4 THEN 'Serializable' 
    WHEN 5 THEN 'Snapshot' END AS TRANSACTION_ISOLATION_LEVEL 
FROM sys.dm_exec_sessions 
where session_id = @@SPID
--ReadCommitted
--

DROP TABLE IF EXISTS
	dbo.kunden,
	dbo.berater;

CREATE TABLE
	dbo.berater
(
	beraterid INT PRIMARY KEY,
	vorname VARCHAR(10),
	nachname VARCHAR(20)
);

INSERT 
	dbo.berater
	VALUES (999,'Benedikt','Schackenberg'
);

CREATE TABLE
	dbo.kunden
(
	Rechnungsid INTEGER PRIMARY KEY,
	beraterid INT
	FOREIGN KEY REFERENCES dbo.berater,
	Rechnungsbetrag BIGINT
   );

INSERT
	dbo.kunden
VALUES 
	(123,999,10000)

INSERT
	dbo.kunden
VALUES 
	(124,999,15000)


SELECT * 
FROM dbo.berater AS ber
JOIN dbo.kunden AS kd
 ON kd.beraterid = ber.beraterid



 BEGIN TRAN

	UPDATE kd
    SET kd.rechnungsbetrag = 90
	FROM dbo.kunden kd 
	WHERE kd.Rechnungsid = 124

	SELECT @@SPID

	SELECT * 
FROM dbo.berater AS ber
JOIN dbo.kunden AS kd
 ON kd.beraterid = ber.beraterid

	UPDATE ber
    SET ber.nachname = 'Petersen'
	FROM dbo.berater ber 
	WHERE ber.beraterid = 999

	SELECT * 
FROM dbo.berater AS ber
JOIN dbo.kunden AS kd
 ON kd.beraterid = ber.beraterid


--	COMMIT TRAN

DROP TABLE IF EXISTS
	dbo.bestellungen
CREATE TABLE dbo.bestellungen
	(
		ArtikelID INTEGER PRIMARY KEY,
		Hersteller VARCHAR(100),
		ArtikelLagerStand VARCHAR(10) UNIQUE
	);

INSERT INTO dbo.bestellungen
VALUES	(1,'Fruchtsaft Unternehmen','ABBC001')

INSERT INTO dbo.bestellungen
VALUES	(2,'Wasser Unternehmen','ABBC002')

INSERT INTO dbo.bestellungen
VALUES	(3,'Mixgetränke Unternehmen','ABBC003')

INSERT INTO dbo.bestellungen
VALUES	(4,'Bier Unternehmen','ABBC004')


/* oh mist fehler*/

INSERT INTO dbo.bestellungen
VALUES	(3,'Mixgetränke Unternehmen','ABBC003')

SELECT 
	c.* 
	FROM dbo.bestellungen c

BEGIN TRAN

	UPDATE B
	SET b.Hersteller = 'TOMATENSAFT UNTERNEHMEN',
	b.ArtikelLagerStand = 'ABBC005' 
	FROM dbo.bestellungen b
	WHERE b.ArtikelID = 2


	UPDATE B
	SET b.Hersteller = 'WEINSCHORLE UNTERNEHMEN',
	b.ArtikelLagerStand = 'ABBC006' 
	FROM dbo.bestellungen b
	WHERE b.ArtikelID = 1

	UPDATE B
	SET b.Hersteller = 'TRAUBENSAFT UNTERNEHMEN',
	b.ArtikelLagerStand = 'ABBC001' 
	FROM dbo.bestellungen b
	WHERE b.ArtikelID = 3


	SELECT 
	c.* 
	FROM dbo.bestellungen c

	COMMIT TRAN