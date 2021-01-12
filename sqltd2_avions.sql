/*
TP SQL
Objectif : Écrire des requêtes SQL Comportant la projection et le filtrage des
données.

NUMPIL: clé de PILOTE, nombre entier
NOMPIL: nom du pilote, chaîne de caractères
ADR: ville de la résidence du pilote, chaîne de caractères
SAL: salaire du pilote, nombre réel
NUMAV: clé d’AVION, nombre entier
NOMAV : modèle de l'avion, chaîne de caractères
CAPACITE: nombre de places d'un avion, nombre entier
LOC: ville de l'aéroport d'attache de l'avion, chaîne de caractères
NUMVOL: clé de VOL, nombre entier
NUMPIL: clé secondaire PILOTE, nombre entier
NUMAV: clé secondaire AVION, nombre entier
VILLE_DEP: ville de départ du vol, chaîne de caractères
VILLE_ARR: ville d'arrivée du vol, chaîne de caractères
H_DEP: heure de départ du vol, nombre entier entre 0 et 23
H_ARR: heure d'arrivée du vol, nombre entier entre 0 et 23
*/

use sqltd2;
drop table IF EXISTS vol, pilote, avion;

CREATE TABLE avion(
	NUMAV int PRIMARY KEY AUTO_INCREMENT,
	NOMAV varchar(30),
    CAPACITE int,
    LOC varchar(50)
);

CREATE TABLE pilote(
	NUMPIL int PRIMARY KEY AUTO_INCREMENT,
	NOMPIL varchar(30),
    ADR varchar(30),
	SAL int
);

CREATE TABLE vol(
	NUMVOL int PRIMARY KEY AUTO_INCREMENT,
	NUMPIL int,
    NUMAV int,
    VILLE_DEP varchar(50),
    VILLE_ARR varchar(50),
    H_DEP int,
    H_ARR int,
    FOREIGN KEY (NUMPIL) REFERENCES pilote(NUMPIL),
    FOREIGN KEY (NUMAV) REFERENCES avion(NUMAV)
);


INSERT INTO pilote VALUES 
    (100,'Jo','Casa',16000),
    (105,'Boris','Constantine',15000),
    (106,'Saber','Tunis',11000),
    (134,'Khalicie','Fes',17000),
    (204,'Sofian','Alger',13000);
insert into pilote values (42, 'Doe','Fesse',25000);

INSERT INTO avion VALUES 
    (1,'AF354',340,'TANGER'),
    (2,'AF1234',265,'ORAN'),
    (3,'AF9876',367,'TANGER'),
    (4,'LU5374',450,'RABAT'),
    (5,'AF6543',500,'TANGER');

INSERT INTO vol VALUES 
    (1,100,2,'ORAN','NICE',18,20),
    (2,204,3,'TANGER','SF',14,16),
    (3,105,1,'TANGER','LA',17,18),
    (4,106,4,'RABAT','PARIS',18,23),
    (5,134,5,'TANGER','NY',12,14);


/*
Ecrire les requêtes SQL répondant aux questions suivantes :
*/

select "select * from pilote;" as "-- 1. Donnez toutes les informations sur les pilotes de la compagnie.";
select * from pilote;

select "select p.NUMPIL, p.NOMPIL, v.VILLE_DEP from pilote p inner join vol v on v.NUMPIL=p.NUMPIL where 1;" as "-- 2. Quels sont les numéros des pilotes en service et les villes de départ de leurs vols ?";
select p.NUMPIL, p.NOMPIL, v.VILLE_DEP from pilote p inner join vol v on v.NUMPIL=p.NUMPIL where 1;

select "select a.NUMAV, a.NOMAV from avion v where a.CAPACITE>=350;" as "-- 3. Donnez la liste des avions dont la capacité est supérieure à 350 passagers.";
select a.NUMAV, a.NOMAV from avion v where a.CAPACITE>=350;

select "select a.NUMAV, a.NOMAV, a.LOC from avion a where a.LOC='TANGER';" as "-- 4. Quels sont les numéros et noms des avions localisés à 'Tanger' ?";
select a.NUMAV, a.NOMAV, a.LOC from avion a where a.LOC='TANGER';

select "select a.LOC from avion a group by a.LOC order by a.LOC asc;\nselect distinct a.LOC from avion a order by a.LOC asc;" as "-- 5. Dans combien de villes distinctes sont localisées des avions ?";
select a.LOC from avion a group by a.LOC order by a.LOC asc;
select distinct a.LOC from avion a order by a.LOC asc;

select "select p.NOMPIL, p.ADR from pilote p where lower(p.ADR)='casa' and p.SAL>=1500;" as "-- 6. Quel est le nom des pilotes domiciliés à 'Casa' dont le salaire est supérieur à 15000 DH ?";
select p.NOMPIL, p.ADR from pilote p where lower(p.ADR)='casa' and p.SAL>=1500;

select "select a.* from avion a where lower(a.LOC)='tanger' OR CAPACITE<=350;" as "-- 7. Quels sont les avions (numéro et nom) localisés à 'Tanger' ou dont la capacité est inférieure à 350 passagers ?";
select a.* from avion a where lower(a.LOC)='tanger' OR CAPACITE<=350;

select "select v.* from vol v where lower(v.VILLE_DEP)='rabat' AND lower(v.VILLE_ARR)='paris' AND v.H_DEP >= 18;" as "-- 8. Liste des vols au départ de 'Rabat' allant à 'Paris' après 18 heures ?";
select v.* from vol v where lower(v.VILLE_DEP)='rabat' AND lower(v.VILLE_ARR)='paris' AND v.H_DEP >= 18;

select "select p.* from pilote p left outer join vol v on v.NUMPIL=p.NUMPIL where v.NUMPIL is NULL;" as "-- 9. Quels sont les numéros des pilotes qui ne sont pas en service ?";
select p.* from pilote p left outer join vol v on v.NUMPIL=p.NUMPIL where v.NUMPIL is NULL;

select "select v.NUMVOL, v.VILLE_DEP from vol v where v.NUMPIL in (100,204);" as "-- 10. Quels sont les vols (numéro, ville de départ) effectués par les pilotes de numéro 100 et 204 ?";
select v.NUMVOL, v.VILLE_DEP from vol v where v.NUMPIL in (100,204);

select "select * from pilote p where lower(p.NOMPIL) like 's%';" as "-- 11. Quels sont les pilotes dont le nom commence par « S » ?";
select * from pilote p where lower(p.NOMPIL) like 's%';

select "select * from pilote p where lower(p.NOMPIL) like '%cie%';" as "-- 12. Quels sont les pilotes qui comportent le groupe de caractères « cie » ?";
select * from pilote p where lower(p.NOMPIL) like '%cie%';

select "select p.* from pilote p where substring(lower(p.NOMPIL),3,1) = 'b';" as "-- 13. Quels sont les pilotes dont la troisième lettre est un « b » ?";
select p.* from pilote p where substring(lower(p.NOMPIL),3,1) = 'b';

