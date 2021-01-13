-- TP3p3
use sqltp3;


drop table if exists CLIENT, AFFAIRE, LIVRAISON, MATERIEL;

create table CLIENT(
    nocli int AUTO_INCREMENT PRIMARY KEY,
    nomcli varchar(50),
    ruecli varchar(50),
    cpcli char(10),
    villecli varchar(50),
    cacli numeric(12,2) default 0
);

create table MATERIEL(
    nomat int AUTO_INCREMENT PRIMARY KEY,
    libmat varchar(50),
    qtemat int,
    pvmat numeric(12,2)
);

create table AFFAIRE(
    noaff int AUTO_INCREMENT PRIMARY KEY,
    nocli int not null,
    nomat int not null,
    dataff DATE,
    nbmat int,
    nbliv int,
    FOREIGN KEY (nocli) REFERENCES CLIENT(nocli),
    FOREIGN KEY (nomat) REFERENCES MATERIEL(nomat)
);

create table LIVRAISON(
    nobl int AUTO_INCREMENT PRIMARY KEY,
    noaff int,
    datexp DATE,
    datliv DATE,
    qliv int,
    FOREIGN KEY (noaff) REFERENCES AFFAIRE(noaff)
);

insert into CLIENT values
(1, 'Dupont Jacques', '8 rue des Cordeliers', '13090', 'Aix en Provence', 56000.0),
(2, 'Dupuis Jean', 'Rue Du Bois Nouveau', '13100', 'Aix en Provence', 985000.0),
(3, 'Serra Albert', '5 rue Leon Blum', '13090', 'Aix en Provence', 553223.0),
(4, 'Danna Sidonie', 'Quartier Saint-Jean', '84130', 'Le Pontet', 812654.0),
(5, 'Sartous Robert', 'Rue de la Molle', '13100', 'Aix en Provence', 456258.0),
(6, 'Texeden Jean', 'Rue de la Republique', '13120', 'Puyricard', 32000.0),
(7, 'Loiseau Gerard', 'Rue de la Grande Place', '13240', 'Meyreuil', 12000.0),
(8, 'Josserand Melodie', 'Avenue de L''Europe', '13090', 'Aix en Provence', 75000.0),
(9, 'Roubaud Aurore', 'Rue Max Weber', '13700', 'Lambesc', 125000.0),
(10, 'Tamburini Franck', 'Boulevard de la Liberte', '13740', 'Saint Cannat', 453000.0),
(11, 'Poitrier Laurent', 'Chemin de Valcros', '13800', 'Aix les Milles', 70000.0),
(12, 'Parlos Jose', 'Chemin de la Bigotte', '13006', 'Marseille', 200000.0);

insert into MATERIEL values
(1, 'Perforateur A', 25, 3654.0),
(2, 'Electro Portatif', 15, 8975.0),
(3, 'Compresseur B', 30, 4658.0),
(4, 'Surpresseur', 45, 6000.0),
(5, 'Electro Pompe', 60, 2985.0),
(6, 'Groupe Electrogene', 28, 15685.0),
(7, 'Pompe Type H', 14, 4657.0),
(8, 'Marteau Piqueur', 14, 6189.0),
(9, 'Compresseur H', 25, 8000.0),
(10, 'Perforateur TTX', 42, 3589.0);

insert into AFFAIRE values
(1,1,8,'2011-09-03', 50,3),
(2,5,5,'2011-10-04', 9,5),
(3,8,5,'2011-11-05', 50,9),
(4,7,6,'2011-11-10', 26,8),
(5,1,4,'2011-12-11', 40,4),
(6,1,10,'2011-12-14', 30,3),
(7,2,7,'2012-01-06', 10,1),
(8,2,8,'2012-01-07', 50,2),
(9,1,8,'2012-01-13', 30, 3);

insert into LIVRAISON values 
(1,3,'2011-11-16', '2011-11-23', 10),
(2,3,'2011-11-23', '2011-12-10', 3),
(3,4,'2011-11-24', '2011-12-01', 2),
(4,5,'2011-12-19', '2011-12-25', 5);


select "select * from CLIENT order by nomcli asc;" as "1 - Afficher la liste de tous les noms de clients avec l’adresse complète de leur
siège social, par ordre alphabétique des noms.";
select * from CLIENT order by nomcli asc;

select "select * from CLIENT where lower(villecli) in ('marseille', 'Aix en provence');" as "2 - Afficher la liste des clients de Marseille et d'Aix en Provence.";
select * from CLIENT where lower(villecli) in ('marseille', 'Aix en provence');

select "select * from MATERIEL where pvmat between 4000.0 and 15000.0 order by pvmat desc;" as "3 - Afficher les matériels dont le prix est compris entre 4 000 et 15 000 €.";
select * from MATERIEL where pvmat between 4000.0 and 15000.0 order by pvmat desc;

select "select * from CLIENT where lower(nomcli) like '%a' or lower(nomcli) REGEXP(' a') order by nomcli;" as "4 - Afficher les clients dont le nom ou le prenom commence par A";
select * from CLIENT where lower(nomcli) like '%a' or lower(nomcli) REGEXP(' a') order by nomcli;

select "" as "5 - Afficher les clients dont le nom de famille est DUPONT ou DANNA";
select * from CLIENT where nomcli like '%dupont%' or nomcli like '%danna%';

select "select * from CLIENT where nomcli like 'p%' or (villecli = 'Aix en Provence' and cacli <= 100000);" as "6 - Afficher les noms et adresses des clients dont le nom commence par un D ou
un P, tels que leur siège social est à Aix en Provence et leur chiffre d’affaires est
supérieur ou égal à 50.000 € et inférieur à 100.000 €";
select * from CLIENT where nomcli like 'p%' or (villecli = 'Aix en Provence' and cacli <= 100000);

select """select nomcli as 'Nom-Prenom', 
ruecli as 'Rue', 
cpcli as 'CP', 
villecli as 'VILLE', 
cacli as 'CA' 
from CLIENT 
where nomcli like 'p%' or 
(villecli = 'Aix en Provence' and cacli <= 100000);
""" as "7 - Faites en sorte que les en-têtes de colonnes du résultat de la requête
précédente soient explicites, par exemple : Nom du client au lieu de nomcli";
select nomcli as 'Nom-Prenom', ruecli as 'Rue', cpcli as 'CP', villecli as 'VILLE', cacli as 'CA' from CLIENT where nomcli like 'p%' or (villecli = 'Aix en Provence' and cacli <= 100000);

select "select sum(qtemat) as QTETOTAL, ROUND(AVG(pvmat),2) as PRIX_MOY from MATERIEL;" as "8 - Calculer le nombre total des matériels dont on dispose et le prix unitaire
moyen des matériels que l’on fabrique (moyenne simple).";
select sum(qtemat) as QTETOTAL, ROUND(AVG(pvmat),2) as PRIX_MOY from MATERIEL;

select """select c.nomcli as CLI_NOM, a.noaff as AFF_ID 
from CLIENT c 
inner join AFFAIRE a on a.nocli=c.nocli 
order by c.nomcli;""" as "9 - Afficher la liste des numéros d’affaire avec pour chacune le nom du client";
select c.nomcli as CLI_NOM, a.noaff as AFF_ID from CLIENT c inner join AFFAIRE a on a.nocli=c.nocli order by c.nomcli;

select """select c.nomcli, c.ruecli, c.cpcli, c.villecli, IFNULL(a.noaff, '-') as AFF_ID 
from CLIENT c 
left outer join AFFAIRE a on a.nocli=c.nocli 
order by c.nomcli;""" as "10 - Afficher la liste de tous les noms et les adresses des clients de l’entreprise,
avec, le cas échéant, leurs numéros d’affaire. Dans le résultat, il peut y avoir un client sans affaire.";
select c.nomcli, c.ruecli, c.cpcli, c.villecli, IFNULL(a.noaff, '-') as AFF_ID from CLIENT c left outer join AFFAIRE a on a.nocli=c.nocli order by c.nomcli;

select """select c.nomcli as CLI_NOM, a.noaff as AFF_ID, a.dataff from CLIENT c 
inner join AFFAIRE a on a.nocli=c.nocli 
where a.dataff >= DATE_SUB('2012-01-13', INTERVAL 50 Day) 
order by a.dataff;""" as "11-12-Afficher les affaires réalisées dans les 50 derniers jours avec le nom du client concerné. Nous sommes le 13/01/2012";
select c.nomcli as CLI_NOM, a.noaff as AFF_ID, a.dataff from CLIENT c inner join AFFAIRE a on a.nocli=c.nocli where a.dataff >= DATE_SUB('2012-01-13', INTERVAL 50 Day) order by a.dataff;

select """select c.nomcli, c.ruecli, c.cpcli, c.villecli, a.noaff as AFF_ID, a.dataff, l.datexp, l.datliv 
from CLIENT c 
inner join AFFAIRE a on a.nocli=c.nocli 
inner join LIVRAISON l on l.noaff=a.noaff
 where DATEDIFF(l.datliv, l.datexp)>=10 
 order by c.nomcli;""" as "13 - Afficher les numéros d’affaire avec le nom du client, pour les livraisons dont la date delivraison dépasse de plus de 10 jours la date d’expédition.";
select c.nomcli, c.ruecli, c.cpcli, c.villecli, a.noaff as AFF_ID, a.dataff, l.datexp, l.datliv 
from CLIENT c 
inner join AFFAIRE a on a.nocli=c.nocli 
inner join LIVRAISON l on l.noaff=a.noaff
 where DATEDIFF(l.datliv, l.datexp)>=10 
 order by c.nomcli;

select """select c.nomcli, 
    c.ruecli, 
    c.cpcli, 
    c.villecli, 
    a.noaff as AFF_ID, 
    a.dataff, 
    l.datexp, 
    l.datliv, 
    DATEDIFF(l.datliv, l.datexp) as 'retard'
from CLIENT c 
inner join AFFAIRE a on a.nocli=c.nocli 
inner join LIVRAISON l on l.noaff=a.noaff
 where DATEDIFF(l.datliv, l.datexp)>=10 
 order by c.nomcli;""" as "14 - Compléter la requête précédente pour afficher, en plus, le nombre de jours de retard de livraison";
select c.nomcli, 
    c.ruecli, 
    c.cpcli, 
    c.villecli, 
    a.noaff as AFF_ID, 
    a.dataff, 
    l.datexp, 
    l.datliv, 
    DATEDIFF(l.datliv, l.datexp) as 'retard'
from CLIENT c 
inner join AFFAIRE a on a.nocli=c.nocli 
inner join LIVRAISON l on l.noaff=a.noaff
 where DATEDIFF(l.datliv, l.datexp)>=10 
 order by c.nomcli;