-- create table USER IF NOT EXISTS (
--     user_id INT AUTO_INCREMENT, 
--     user_name VARCHAR(50), 
--     user_surname VARCHAR(50), 
--     user_email VARCHAR(100), 
--     user_cdate DATE, 
--     user_date DATETIME, 
--     PRIMARY KEY(user_id)
-- );

-- Langage de définition de Données
-- CREATE DATABASE poe_formation;
-- USE poe_formation;

drop table IF EXISTS personne, employee, vehicule;

CREATE TABLE personne(
	num int PRIMARY KEY AUTO_INCREMENT,
	nom varchar(30),
	prenom varchar(30),
	salaire int,
	ville varchar(30)
);
INSERT INTO personne VALUES
    (1, 'Durand', 'Philippe', 2000, 'Marseille'),
    (2, 'Leberre', 'Bernard', 1500, 'Paris'),
    (3, 'Benammar', 'Pierre', 1800, 'Lyon'),
    (4, 'Hadad', 'Karim', 2500, 'Paris'),
    (5, 'Cooper', 'David', 3000, 'Marseille');
INSERT INTO personne (num, nom, prenom) VALUES (6, 'Benatia', 'Sonia');
UPDATE personne SET salaire = 1600, ville = 'Toulouse' WHERE nom = 'Benatia';
UPDATE personne SET salaire = 1600, ville = 'Toulouse' WHERE nom = 'Benatia';

--exit;

CREATE TABLE employee(
	cin char(6),
	prenom char(20),
	nom char(20),
	CONSTRAINT pk_employee PRIMARY KEY(nom,prenom)
);
ALTER TABLE employee DROP PRIMARY KEY;
ALTER TABLE employee ADD CONSTRAINT pk_employee PRIMARY KEY(cin);


CREATE table vehicule(
    immatriculation int PRIMARY KEY AUTO_INCREMENT,
    marque varchar(30),
    model varchar(30),
    annee int,
    nump INT,
    FOREIGN KEY (nump) REFERENCES personne(num)
);

INSERT INTO vehicule (immatriculation , marque, model, annee) 
VALUES (600, 'Ford', 'Kuga', 2019);

INSERT INTO vehicule VALUES
    (100, 'Peugeot', '5008', 2008, 5),
    (200, 'Renault', 'Clio', 2000, 4),
    (300, 'Ford', 'Fiesta', 2010, 1),
    (400, 'Peugeot', '106', 2002, 3),
    (500, 'Citroen', 'C4', 2015, 4),
    (700, 'Fiat', 'Punto', 2008, 5);
select * from personne where LOWER(ville) = 'marseille' OR LOWER(ville)='lyon';



-- Supprime toutes les personnes ayant un salaire supérieur à 2000 et habitant Marseille
-- DELETE FROM personne WHERE salaire > 2000 AND ville = 'Marseille';

 -- Q1 Ecrire une requète qui permet de sélectionner 
 -- les personnes qui habitent Marseille ou Lyon
 select * from personne where LOWER(ville) = 'marseille' OR LOWER(ville)='lyon';

 -- Q2 Ecrire une requête qui permet de sélectionner les personnes 
 -- dont le salaire est compris entre 2000 et 3000
select * from personne where salaire between 2000 and 3000;

select * from personne where LOWER(ville) = 'marseille' OR (salaire <= 2000 OR salaire >= 2500) ;

-- Sélectionne toutes les personnes qui ont un salaire égal à 2000 ou 3000
SELECT * FROM personne
WHERE salaire IN (2000, 3000);
-- Q3 Ecrire une requête qui permet de sélectionner les personnes qui habitent Marseille et
-- dont le salaire est soit inférieur à 2000 soit supérieur à 2500
SELECT * FROM personne
WHERE ville='Marseille' AND (salaire <= 2000 OR salaire >= 2500);
SELECT * FROM personne
WHERE ville='Marseille' AND salaire NOT BETWEEN 2000 AND 2500;
-- Sélectionne toutes les personnes dont le nom de la ville contient le caractère a
SELECT * FROM personne
WHERE ville like '%a%';
-- Sélectionne toutes les personnes dont le nom de la ville commence par le caractère p
SELECT * FROM personne
WHERE ville like 'p%';
-- Sélectionne toutes les personnes dont le nom de la ville finit par le caractère s
SELECT * FROM personne
WHERE ville like '%s';
-- Sélectionne toutes les personnes dont le nom de la ville a un caractère r en troisIème lettre, position
SELECT * FROM personne
WHERE ville like '__r%';
-- Sélectionne tous les vehicules dont le numéro de propriétaire est non-null
SELECT *
FROM vehicule
WHERE nump IS NOT NULL;
-- Pour remplacer les valeurs nulles par une autre valeur, on peut utiliser la fonction ifnull()
SELECT marque, IFNULL(nump, 'pas de propriétaire') AS propriétaire
FROM vehicule;
-- Sélectionne tous les vehicules ordonné selon le numéro du propriétaire (ASC croissant par défaut)
SELECT *
FROM vehicule
WHERE nump IS NOT NULL
ORDER BY nump;
-- Sélectionne tous les vehicules ordonné selon le numéro du propriétaire (Si décroissant, à déclarer)
SELECT *
FROM vehicule
WHERE nump IS NOT NULL
ORDER BY nump DESC;
-- Compte le nombre de véhicule par personne 
SELECT nump, COUNT(*) AS nombre_vehicule
FROM vehicule
WHERE nump IS NOT NULL
GROUP BY nump;
-- Sélectionne toutes les personnes qui ont plus d'1 véhicule
-- HAVING nous permet de filtrer les résultats de la fonction d'agrégation , ici COUNT()
SELECT nump, COUNT(*) AS nombre_vehicule
FROM vehicule
WHERE nump IS NOT NULL
GROUP BY nump
HAVING nombre_vehicule > 1;
-- Fonctions d'aggrégation
-- MAX : maximum
-- MIN : minimum
-- COUNT : Compte-tuple
-- SUM : Somme
-- AVG : Moyenne
-- Compte la somme des salaires par ville
SELECT ville, SUM(salaire) AS somme_salaire_par_ville
FROM personne
GROUP BY ville;
-- Sélectionne les numéros de personnes qui ont un véhicule Renault ou Citroen
SELECT nump
FROM vehicule
WHERE marque = 'Renault' OR marque = 'Citroen'
GROUP BY nump;
