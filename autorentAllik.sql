create database autorentAllik;
use autorentAllik;

--TABLE AUTO
CREATE TABLE auto(
autoID int not null Primary key IDENTITY(1,1),
regNumber char(6) UNIQUE,
markID int,
varv varchar(20),
v_aasta int,
kaigukastID int,
km decimal(6,2)
);
SELECT * FROM auto
INSERT INTO auto(regNumber, markID, varv, v_aasta, kaigukastID, km)
VALUES ('123ABC', 1, 'punane', '2024', 1, '200'),
('985HGT', 2, 'must', '2019', 2, '300'),
('230TVK', 3, 'roheline', '2013', 1, '150');
ALTER TABLE auto
ADD FOREIGN KEY (markID) REFERENCES mark(markID);
ALTER TABLE auto
ADD FOREIGN KEY (kaigukastID) REFERENCES kaigukast(kaigukastID);



--TABLE MARK
CREATE TABLE mark(
markID int not null Primary key IDENTITY(1,1),
autoMark varchar(30) UNIQUE
);
INSERT INTO mark(autoMark)
VALUES ('Ziguli');
INSERT INTO mark(autoMark)
VALUES ('Lambordzini');
INSERT INTO mark(autoMark)
VALUES ('BMW');
SELECT * FROM mark;


--TABLE KAIGUKAST
CREATE TABLE kaigukast(
kaigukastID int not null Primary key IDENTITY(1,1),
kaigukast varchar(30) UNIQUE
);
INSERT INTO kaigukast(kaigukast)
VALUES ('Automaat');
INSERT INTO kaigukast(kaigukast)
VALUES ('Manual');
SELECT * FROM kaigukast;


--TABLE KLIENT
CREATE TABLE klient(
klientiId int not null Primary key IDENTITY(1,1),
klientiNimi varchar (50),
telefon varchar (20),
aadress varchar (50),
soiduKogemus varchar (30));
SELECT * FROM klient;
INSERT INTO klient(klientiNimi, telefon, aadress, soiduKogemus)
VALUES ('Valeria', '5859153', 'Narva mnt 5', '4 aastane'),
('Daria', '5958713', 'Majaka 11', '3 aastane'),
('Alexandra', '59301753', 'Tallinna tee 4', '2 aastane');
select * from klient;


--TABLE AMET
CREATE TABLE amet(
ametiID int not null Primary key IDENTITY(1,1),
markID int,
ametiNimi varchar(50),
FOREIGN KEY (markID) REFERENCES mark(markID)
);



--TABLE TOOTAJA
CREATE TABLE tootaja (
tootajaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
c VARCHAR(50),
markID int,
FOREIGN KEY (markID) REFERENCES mark(markID)
);
INSERT INTO tootaja(tootajaNimi, markID)
VALUES ('Kirill', 1),
('Bogdan', 2),
('Masha', 3);
select * from tootaja;
drop table tootaja;


--TABLE RENDILEPPING
CREATE TABLE rendiLeping(
lepingID int not null Primary key IDENTITY(1,1),
rendiAlgus date,
rendiLopp date,
kliendID int,
regNumber char(6) UNIQUE,
rendiKestvus int,
hindKokku decimal (5,2),
tootajaID int
);
ALTER TABLE rendileping
ADD FOREIGN KEY (kliendID) REFERENCES klient(klientiID);
ALTER TABLE rendileping
ADD FOREIGN KEY (regNumber) REFERENCES auto(regNumber);
ALTER TABLE rendileping
ADD FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID);
INSERT INTO rendiLeping(rendiAlgus, rendiLopp, kliendID, regNumber, rendiKestvus, hindKokku, tootajaID)
VALUES ('2025-11-24', '2025-12-24', 1, '123ABC', '300', '600', 1),
('2024-09-13', '2024-10-23', 2, '985HGT', '120', '500', 2),
('2024-06-30', '2024-07-10', 3, '230TVK', '100', '300', 3);
drop table rendiLeping;
select * from rendileping;



--ÜLESANNE 1
SELECT auto.regNumber, kaigukast.kaigukast 
FROM auto INNER JOIN kaigukast ON auto.kaigukastID = kaigukast.kaigukastID;

--ÜLESANNE 2
SELECT auto.regNumber, mark.autoMark 
FROM auto INNER JOIN mark ON auto.markID = mark.markID;

--ÜLESANNE 3
SELECT rendiLeping.regNumber, auto.varv, tootaja.tootajanimi 
FROM rendiLeping INNER JOIN auto ON rendiLeping.regNumber = auto.regNumber INNER JOIN tootaja ON rendiLeping.tootajaID = tootaja.tootajaID;

--ÜLESANNE 4
SELECT COUNT(regNumber) AS RendiKokku, SUM(hindKokku) AS HindKokku FROM rendiLeping;

--ÜLESANNE 5
SELECT tootajaNimi AS TootajaNimi, autoMark AS Mark
FROM tootaja INNER JOIN mark ON tootaja.tootajaID = mark.markID;

GRANT SELECT, INSERT ON rendiLeping to tootaja;