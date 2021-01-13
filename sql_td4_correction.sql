-- Langage de définition de Données

​

CREATE DATABASE poe_formation;

​

USE poe_formation;

​

CREATE TABLE personne(

	id int PRIMARY KEY AUTO_INCREMENT,

	nom varchar(30),

	prenom varchar(30),

	salaire int,

	ville varchar(30)

);

​

CREATE TABLE employee(

	cin char(6),

	prenom char(20),

	nom char(20),

	CONSTRAINT pk_employee PRIMARY KEY(nom,prenom)

);

​

CREATE TABLE vehicule(

	immatriculation int PRIMARY KEY AUTO_INCREMENT,

    marque varchar(30),

    modele varchar(30),

    annee int,

    nump int,

    FOREIGN KEY (nump) REFERENCES personne(num)

);

​

CREATE TABLE customer(

	id int PRIMARY KEY AUTO_INCREMENT,

	firstname varchar(30),

	lastname varchar(30),

	city varchar(30),

	country varchar(30),

    phone varchar(30)

);

​

CREATE TABLE supplier(

	id int PRIMARY KEY AUTO_INCREMENT,

	compagny_name varchar(30),

	contact_name varchar(30),

	city varchar(30),

	country varchar(30),

    phone varchar(30),

    fax varchar(30),

    id_customer int,

    FOREIGN KEY (id_customer) REFERENCES customer(id)

);

​

ALTER TABLE employee

DROP PRIMARY KEY;

​

ALTER TABLE employee

ADD CONSTRAINT pk_employee PRIMARY KEY(cin);

​

-- Langage de manipulation de Données

​

INSERT INTO personne VALUES

(1, 'Durand', 'Philippe', 2000, 'Marseille'),

(2, 'Leberre', 'Bernard', 1500, 'Paris'),

(3, 'Benammar', 'Pierre', 1800, 'Lyon'),

(4, 'Hadad', 'Karim', 1500, 'Paris'),

(5, 'Cooper', 'David', 3000, 'Marseille');

​

INSERT INTO personne VALUES (5, 'Cooper', 'David', 3000, 'Marseille');

​

INSERT INTO personne (num, nom, prenom) VALUES (6, 'Benatia', 'Sonia');

​

INSERT INTO vehicule VALUES

(100, 'Peugeot', '5008', 2008, 5),

(200, 'Renault', 'Clio', 2000, 4),

(300, 'Ford', 'Fiesta', 2010, 1),

(400, 'Peugeot', '106', 2002, 3),

(500, 'Citroen', 'C4', 2015, 4),

(700, 'Fiat', 'Punto', 2008, 5);

​

INSERT INTO vehicule (immatriculation , marque, modele, annee) VALUES (600, 'Ford', 'Kuga', 2019);

​

INSERT INTO customer VALUES

(100, 'NOM1', 'PRENOM1', 'VILLE1', 'COUNTRY1', 'PHONE1'),

(200, 'NOM2', 'PRENOM2', 'VILLE2', 'COUNTRY2', 'PHONE2'),

(300, 'NOM3', 'PRENOM3', 'VILLE3', 'COUNTRY3', 'PHONE3'),

(400, 'NOM4', 'PRENOM4', 'VILLE4', 'COUNTRY4', 'PHONE4'),

(500, 'NOM5', 'PRENOM5', 'VILLE5', 'COUNTRY5', 'PHONE5'),

(600, 'NOM6', 'PRENOM6', 'VILLE6', 'COUNTRY6', 'PHONE6');

​

INSERT INTO supplier VALUES

(100, 'COMPAGNYNOM1', 'CONTACTNOM1', 'SUPPLIERVILLE1', 'SUPPLIERCOUNTRY1', 'SUPPLIERPHONE1', 'SUPPLIERFAX1',100),

(200, 'COMPAGNYNOM2', 'CONTACTNOM2', 'SUPPLIERVILLE2', 'SUPPLIERCOUNTRY2', 'SUPPLIERPHONE2', 'SUPPLIERFAX1', 100),

(300, 'COMPAGNYNOM3', 'CONTACTNOM3', 'SUPPLIERVILLE3', 'SUPPLIERCOUNTRY3', 'SUPPLIERPHONE3', 'SUPPLIERFAX1', 300),

(400, 'COMPAGNYNOM4', 'CONTACTNOM4', 'SUPPLIERVILLE4', 'SUPPLIERCOUNTRY4', 'SUPPLIERPHONE4', 'SUPPLIERFAX1', 400),

(500, 'COMPAGNYNOM5', 'CONTACTNOM5', 'SUPPLIERVILLE5', 'SUPPLIERCOUNTRY5', 'SUPPLIERPHONE5', 'SUPPLIERFAX1', 500),

(600, 'COMPAGNYNOM6', 'CONTACTNOM6', 'SUPPLIERVILLE6', 'SUPPLIERCOUNTRY6', 'SUPPLIERPHONE6', 'SUPPLIERFAX1', 500);

​

-- Supprime toutes les personnes ayant un salaire supérieur à 2000 et habitant Marseille

DELETE FROM personne

WHERE salaire > 2000 AND ville = 'Marseille';

​

-- Modifie le salaire et la ville aux tuples ayant le nom Benatia

UPDATE personne

SET salaire = 1600, ville = 'Toulouse'

WHERE nom = 'Benatia';

​

-- Modifie les villes de tous les tuples de la table personne

UPDATE personne

SET ville = 'Marseille';

​

-- Langage d'interrogation de Données

​

-- Une requete SQL de lecture est composée d'au moins deux clauses :

​

-- Sélectionne tous les tuples de la table personne

SELECT *

FROM personne;

​

-- Sélectionne les deux premières personnes

SELECT *

FROM personne

LIMIT 2;

​

-- Sélectionne la ville de chaque personne

SELECT ville 

FROM personne; 

​

-- Sélectionne la ville de chaque personne et supprime les doublons

SELECT distinct(ville) 

FROM personne;

​

-- Compte le nombre de ville diffèrentes dans la table personne

SELECT COUNT(distinct(ville)) as nombre_ville

FROM personne;

​

-- Sélectionne toutes les personnes qui habitent Marseille de la table personne

SELECT *

FROM personne

WHERE ville = 'Marseille';

​

-- Il est possible de définir plusieurs conditions dans un WHERE

-- En utilisant les opérateurs logiques : AND, OR, !

​

-- Q1 Ecrire une requète qui permet de sélectionner les personnes qui habitent Marseille ou Lyon

​

SELECT *

FROM personne

WHERE ville = 'Marseille' OR ville = "Lyon";

​

-- Q2 Ecrire une requête qui permet de sélectionner les personnes dont le salaire est compris entre 2000 et 3000

​

SELECT * FROM personne

WHERE salaire >= 2000 AND salaire <= 3000;

​

SELECT * FROM personne

WHERE salaire BETWEEN 2000 AND 3000;

​

-- Sélectionne toutes les personnes qui ont un salaire égal à 2000 ou 3000

SELECT * FROM personne

WHERE salaire IN (2000, 3000);

​

-- Q3 Ecrire une requête qui permet de sélectionner les personnes qui habitent Marseille et 

-- dont le salaire est soit inférieur à 2000 soit supérieur à 2500

​

SELECT * FROM personne

WHERE ville='Marseille' AND (salaire <= 2000 OR salaire >= 2500); 

​

SELECT * FROM personne

WHERE ville='Marseille' AND salaire NOT BETWEEN 2000 AND 2500; 

​

-- Sélectionne toutes les personnes dont le nom de la ville contient le caractère a

SELECT * FROM personne

WHERE ville like '%a%';

​

-- Sélectionne toutes les personnes dont le nom de la ville commence par le caractère p

SELECT * FROM personne

WHERE ville like 'p%';

​

-- Sélectionne toutes les personnes dont le nom de la ville finit par le caractère s

SELECT * FROM personne

WHERE ville like '%s';

​

-- Sélectionne toutes les personnes dont le nom de la ville a un caractère r en troisIème lettre, position

SELECT * FROM personne

WHERE ville like '__r%';

​

-- Sélectionne tous les vehicules dont le numéro de propriétaire est non-null

SELECT *

FROM vehicule

WHERE nump IS NOT NULL;

​

-- Pour remplacer les valeurs nulles par une autre valeur, on peut utiliser la fonction ifnull()

SELECT marque, IFNULL(nump, 'pas de propriétaire') AS propriétaire

FROM vehicule;

​

-- Sélectionne tous les vehicules ordonné selon le numéro du propriétaire (ASC croissant par défaut)

SELECT *

FROM vehicule

WHERE nump IS NOT NULL

ORDER BY nump;

​

-- Sélectionne tous les vehicules ordonné selon le numéro du propriétaire (Si décroissant, à déclarer)

SELECT *

FROM vehicule

WHERE nump IS NOT NULL

ORDER BY nump DESC;

​

-- Compte le nombre de véhicule par personne 

SELECT nump, COUNT(*) AS nombre_vehicule

FROM vehicule

WHERE nump IS NOT NULL

GROUP BY nump;

​

-- Sélectionne toutes les personnes qui ont plus d'1 véhicule

-- HAVING nous permet de filtrer les résultats de la fonction d'agrégation , ici COUNT()

SELECT nump, COUNT(*) AS nombre_vehicule

FROM vehicule

WHERE nump IS NOT NULL

GROUP BY nump

HAVING nombre_vehicule > 1;

​

-- Fonctions d'aggrégation

-- MAX : maximum

-- MIN : minimum

-- COUNT : Compte-tuple

-- SUM : Somme

-- AVG : Moyenne

​

-- Compte la somme des salaires par ville

SELECT ville, SUM(salaire) AS somme_salaire_par_ville

FROM personne

GROUP BY ville;

​

-- Sélectionne les numéros de personnes qui ont un véhicule Renault ou Citroen

SELECT nump

FROM vehicule

WHERE marque = 'Renault' OR marque = 'Citroen'

GROUP BY nump;

​

-- JOINTURES

​

-- Jointure implicite

​

SELECT nom, prenom, ville, marque, modele

FROM personne, vehicule

WHERE personne.num = vehicule.nump;

​

-- Avec des Alias si ambiguité (erreur !!! sur v.num, fait pour l'exemple)

-- SELECT nom, prenom, ville, marque, modele

-- FROM personne p, vehicule v

-- WHERE p.num = v.num;

​

-- Pas d'Alias si pas d'ambiguité

SELECT nom, prenom, ville, marque, modele

FROM personne , vehicule 

WHERE num = nump;

​

-- Jointures explicites avec JOIN ... ON

​

-- JOIN ... ON = Comme la jointure implicite

​

SELECT nom, prenom, ville, marque, modele

FROM personne

JOIN vehicule ON num = nump;

​

-- LEFT JOIN ... ON = jointure gauche

-- Récupère les personnes n'ayant pas de véhicules 

​

SELECT nom, prenom, ville, marque, modele

FROM personne

LEFT JOIN vehicule ON num = nump;

​

-- RIGHT JOIN ... ON = Jointure droite

-- Récupère les voitures n'ayant pas de propriétaires 

​

SELECT firstname, lastname, ville, marque, modele

FROM personne

RIGHT JOIN vehicule ON num = nump;

​

SELECT *

FROM customer c

JOIN supplier s ON c.id = s.id_customer;

​

-- VUE --> Table virtuelle

-- peut interrogee comme une table 

​

-- VUE SINGLE-TABLE

CREATE OR REPLACE VIEW marseillais AS

SELECT num, nom, prenom, salaire

FROM personne

WHERE ville = 'Marseille';

​

SELECT *

FROM marseillais;

​

DROP VIEW marseillais;

​

-- VUE MULTI-TABLES

CREATE OR REPLACE VIEW vehicule_marseillais AS

SELECT num, nom, prenom, marque, modele

FROM personne, vehicule

WHERE ville = 'Marseille'

AND num = nump;

​

SELECT *

FROM vehicule_marseillais;

​

CREATE OR REPLACE VIEW cadre_marseillais AS

SELECT *

FROM marseillais

WHERE salaire >= 2000;

​

SELECT *

FROM cadre_marseillais;

​

-- Modifier le modèle de la table vehicule est possible

UPDATE vehicule_marseillais

SET modele = 'focus'

WHERE marque = 'ford';

​

-- Tandis que, modifier le nom de la table personne et

-- le modèle de la table vehicule est impossible

UPDATE vehicule_marseillais

SET nom = 'mercure',

modele = 'focus'

WHERE marque = 'ford';

​

-- Insérer un tuple dans la table vehicule est possible

INSERT INTO vehicule_marseillais

SET modele = 'ibiza',

marque = 'seat';

​

-- Insérer un tuple dans la table vehicule et dans la table personne est impossible

INSERT INTO vehicule_marseillais

SET nom = "Baton",

prenom = 'Jean',

modele = 'ibiza',

marque = 'seat';

​

-- Langage de contrôle de Données

​

-- LCD = consiste à gérer les droits selon certains utilisateurs

​

CREATE USER user2021 IDENTIFIED BY 'user2021';

-- CREATE USER Username IDENTIFIED BY 'password';

​

-- LISTE DES PRIVILEGES :

-- CREATE : Autorisé à créer des bases et des tables

-- DROP : Autorisé à supprimer des bases et des tables

-- DELETE : Autorisé à supprimer des tuples d'une table spécifique

-- INSERT : Autorisé d'insérer des tuples dans une table

-- SELECT : Autorisé de lire une base de données

-- UPDATE : Autorisé de modifier des tuples d'une table spécifique

​

-- GRANT attribut tous les privilèges ici à user2021

GRANT ALL PRIVILEGES ON poe_formation.* TO user2021;

​

-- REVOKE enlève tous les privilèges ici à user2021

REVOKE ALL PRIVILEGES, GRANT OPTION FROM user2021;

​

-- REVOKE enlève le privilège de modifiction ici à user2021

REVOKE UPDATE ON poe_formation FROM user2021;

​

-- Supprime un utilisateur ici user 2021

DROP USER user2021;

​