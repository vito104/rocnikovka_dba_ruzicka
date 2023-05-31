CREATE DATABASE rocnikovka_ruzicka;
USE rocnikovka_ruzicka;




CREATE TABLE komise_pro_souteze (
    id_komise INT primary key AUTO_INCREMENT,
    nazev_komise VARCHAR(70) NOT NULL UNIQUE
    );

INSERT INTO komise_pro_souteze (nazev_komise)VALUES 
("Komise FACR"),
("Ridici komise pro Cechy"),
("Ridici komise pro Moravu a Slezsko"),
("Krajsky fotbalovy svaz Pardubice"),
("Krajsky fotbalový svaz Hradec Kralove"),
("Okresni fotbalovy svaz Usti nad Orlici"),
("Okresni fotbalovy svaz Svitavy"),
("Okresni fotbalovy svaz Pardubice"),
("Okresni fotbalovy svaz Trutnov"),
("Okresni fotbalovy svaz Hradec Kralove");

CREATE TABLE souteze(
    id_souteze INT PRIMARY KEY AUTO_INCREMENT,
    id_komise INT NOT NULL,
    nazev_souteze VARCHAR(30) NULL UNIQUE,
    poradi_souteze INT NOT NULL,
    CONSTRAINT fk_kom_sou FOREIGN KEY (id_komise) REFERENCES komise_pro_souteze(id_komise)
    );

INSERT INTO souteze(id_komise, nazev_souteze, poradi_souteze) VALUES
(1, "Fortuna liga", 1),
(1, "Fortuna narodni liga", 2),
(2, "Fortuna Divize C", 4),
(6, "Okresni prebor Usti nad Orlici", 8),
(3, "MSFL", 3),
(4, "Krajsky prebor Pardubice", 5),
(5, "Kralovehradecky krajsky prebor", 5),
(10, "Okresni prebor Hradec Kralove", 8),
(7, "Okresni prebor Svitavy", 8),
(9, "Okresni prebor Trutnov", 8);

CREATE TABLE role(
    id_role INT PRIMARY KEY AUTO_INCREMENT,
    nazev VARCHAR(30) NOT NULL UNIQUE);

INSERT INTO role (nazev) VALUES
("Hrot"),
("Leve kridlo"),
("Prave kridlo"),
("Zaloznik"),
("Stoper"),
("Levy bek"),
("Pravy bek"),
("Trener"),
("Asistent trenera"),
("Brankar");

CREATE TABLE zeme(
    id_zeme INT PRIMARY KEY AUTO_INCREMENT,
    nazev_zeme VARCHAR(30) NOT NULL UNIQUE);

INSERT INTO zeme(nazev_zeme) VALUES
("Cesko"),
("Slovensko"),
("Polsko"),
("Rakousko"),
("Uganda"),
("Chorvatsko"),
("Anglie"),
("Irsko"),
("USA"),
("Japonsko");

CREATE TABLE osoby(
    id_osoby INT PRIMARY KEY AUTO_INCREMENT,
    jmeno VARCHAR(30) NOT NULL,
    prijmeni VARCHAR(30) NOT NULL,
    plat FLOAT NOT NULL,
    id_zeme INT NOT NULL,
    CONSTRAINT fk_hrac_zeme FOREIGN KEY(id_zeme) REFERENCES zeme(id_zeme));

INSERT INTO osoby(jmeno, prijmeni, plat, id_zeme) VALUES
("Jan", "Soucek", 15000,1),
("Milan", "Baros", 250000,1),
("Antonin", "Vanicek", 150000,7),
("Michal", "Sindelar", 1000,1),
("Vit", "Ruzicka", 0,2),
("Ales", "Majvald", 19800,7),
("Patrik", "Langer", 25000,1),
("Zdenek", "Vanous", 7000,8),
("Filip", "Grepl", 6500,1),
("Filip", "Brambora", 16800,5),
("Ludek", "Riha", 25000,5),
("Vladimir", "Chuda", 25000,1),
("Jaroslav", "Spacek", 13000,1),
("Petr", "Vajgl", 15333,1),
("Josef", "Simpson", 16500,1);

CREATE TABLE mesto(
    id_mesta INT PRIMARY KEY AUTO_INCREMENT,
    nazev VARCHAR(70) NOT NULL);

INSERT INTO mesto(nazev) VALUES
("Praha"),
("Ostrava"),
("Drnovice"),
("Blsany"),
("Usti nad Orlici"),
("Ceska Trebova"),
("Holice"),
("Pardubice"),
("Letohrad"),
("Sopotnice");

CREATE TABLE stadiony(
    id_stad INT PRIMARY KEY AUTO_INCREMENT,
    nazev VARCHAR(50) NOT NULL,
    kapacita INT NOT NULL,
    splnuje_top BOOL NOT NULL,
    id_mesta INT NOT NULL,
    CONSTRAINT fk_stadion_mesto FOREIGN KEY(id_mesta) REFERENCES mesto(id_mesta),
    CONSTRAINT unik_stad_mesto UNIQUE (nazev, id_mesta)

);

INSERT INTO stadiony (nazev, kapacita, splnuje_top, id_mesta) VALUES
("Bazaly", 17372, TRUE, 2),
("Stadion TJ Jiskra", 5000, FALSE, 5),
("Stadion pod Jelenici", 2000, FALSE, 6),
("Sopotnice arena", 5000, FALSE, 10),
("Stadion Blsany", 2700, TRUE, 4),
("Stadion Drnovice", 3600, TRUE, 3),
("Eden arena", 20300, TRUE, 1),
("OEZ Stadion", 1500, FALSE, 9),
("Mestsky stadion Holice", 750, FALSE, 7),
("Dolicek", 6500, TRUE, 1);




CREATE TABLE klub(
    id_klubu INT PRIMARY KEY AUTO_INCREMENT,
    id_souteze INT NOT NULL,
    nazev_klubu VARCHAR(45) NOT NULL,
    rok_zalozeni DATE NOT NULL,
    id_stad INT UNIQUE,
    CONSTRAINT fk_stad_klub FOREIGN KEY (id_stad) REFERENCES stadiony(id_stad),
    CONSTRAINT fk_stad_soutez FOREIGN KEY (id_souteze) REFERENCES souteze(id_souteze),
    CONSTRAINT unikatnost_klubu UNIQUE (id_souteze, nazev_klubu, rok_zalozeni)
    );

INSERT INTO klub(id_souteze, nazev_klubu, rok_zalozeni, id_stad) VALUES
(1, "FC Banik ostrava", "1922-09-08", 1),
(4, "TJ Sopotnice", "1947-01-01", 4),
(3, "TJ Jiskra Usti nad Orlici", "1904-01-01", 2),
(6, "FK Ceska Trebova", "1908-01-01", 3),
(1, "SK Slavia Praha", "1892-11-02", 7),
(2, "FC Petra Drnovice", "1932-06-01", 6),
(1, "FK Chmel Blsany", "1946-07-03", 5),
(3, "FK Letohrad", "1919-06-16", 8),
(6, "FK Holice", "1935-04-18", 9),
(1, "FK Bohemians Praha", "1905-09-16", 10);

CREATE TABLE osoby_role(
    id_osoba_role INT PRIMARY KEY AUTO_INCREMENT,
    id_klubu INT,
    id_osoby INT NOT NULL,
    id_role INT NOT NULL,
    CONSTRAINT fk_klub FOREIGN KEY (id_klubu) REFERENCES klub(id_klubu),
    CONSTRAINT fk_osoba FOREIGN KEY (id_osoby) REFERENCES osoby(id_osoby),
    CONSTRAINT fk_role FOREIGN KEY (id_role) REFERENCES role(id_role),
    CONSTRAINT unikatnost_osoby_klubu_role UNIQUE (id_klubu, id_osoby, id_role)
);   

INSERT INTO role_osoby(id_klubu, id_osoby, id_role) VALUES
(5,1,3),
(6,4,10),
(5,10,8),
(10,10,2),
(10,3,1),
(4,5,6),
(8,11,3),
(6,4,5),
(9,15,6),
(5,13,9);

CREATE TABLE zapasy(
    id_zapasu INT PRIMARY KEY AUTO_INCREMENT,
    id_stad INT NOT NULL,
    datum_zapasu DATE NOT NULL,
    CONSTRAINT fk_zapas_stad FOREIGN KEY(id_stad) REFERENCES stadiony(id_stad),
    CONSTRAINT unikatnost_zapasu UNIQUE (id_stad, datum_zapasu)
);

INSERT INTO zapasy(id_stad, datum_zapasu) VALUES
(2, "2022-09-03"),
(5, "2023-03-01"),
(4, "2022-11-30"),
(9, "2023-01-16"),
(3, "2023-03-31"),
(6, "2022-05-05"),
(7, "2020-12-12"),
(10, "2022-12-15"),
(1, "2023-04-11"),
(9, "2023-04-01");

CREATE TABLE kluby_zapasy(
    id_klub_zapas INT PRIMARY KEY AUTO_INCREMENT,
    id_zapasu INT NOT NULL,
    id_klubu INT NOT NULL,
    CONSTRAINT fk_zapasu FOREIGN KEY(id_zapasu) REFERENCES zapasy(id_zapasu),
    CONSTRAINT fk_klubu FOREIGN KEY(id_klubu) REFERENCES klub(id_klubu),
    CONSTRAINT regulernost_zapasu UNIQUE(id_klubu, id_zapasu)
);

DELIMITER $$
CREATE TRIGGER overeni_zapasu
    BEFORE INSERT ON kluby_zapasy
    FOR EACH ROW
BEGIN
IF ((SELECT COUNT(id_zapasu) FROM kluby_zapasy WHERE id_zapasu = new.id_zapasu) >= 2) THEN   
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'K ZAPASU JSOU JIZ PRIRAZENY 2 TYMY...';
    END IF;
END; $$
DELIMITER ;

INSERT INTO kluby_zapasy (id_zapasu, id_klubu) VALUES
(1,3),
(1,8),
(2,7),
(2,10),
(3,2),
(3,9),
(8,10),
(8,5),
(6,6),
(6,7);