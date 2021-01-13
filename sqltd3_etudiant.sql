use sqltd3;

drop table if exists ETUDIANT, COURS, EXAMEN;

create table ETUDIANT(
    Matricule varchar(50) PRIMARY KEY,
    Nom varchar(50),
    Prenom varchar(50),
    DateNaissance date,
    Niveau varchar(50)
);

create table COURS(
    Code varchar(50) PRIMARY KEY,
    NomCours varchar(50),
    Enseignant varchar(50)

);

create table EXAMEN(
    Matricule varchar(50),
    Code varchar(50),
    Note decimal(4,2), -- note sur 20/40
    CONSTRAINT pk_examen PRIMARY KEY(Matricule,Code),
    FOREIGN KEY (Code) REFERENCES COURS(Code),
    FOREIGN KEY (Matricule) REFERENCES ETUDIANT(Matricule)
);


INSERT INTO ETUDIANT VALUES 
('e1','NOM1','PRENOM1','1999-01-02','M1'),
('e2','NOM2','PRENOM2','1998-03-04','M2'),
('e3','NOM3','PRENOM3','1997-05-06','M3'),
('e4','NOM4','PRENOM4','1998-07-08','M2'),
('e5','NOM5','PRENOM5','1999-09-10','M2');

INSERT INTO COURS VALUES 
('c1','MAT1','PROF1'),
('c2','MAT2','PROF2'),
('c3','MAT3','PROF3'),
('c4','MAT4','PROF4'),
('c5','MAT5','PROF5');

INSERT INTO EXAMEN VALUES 
('e1','c5',15.8),
('e2','c4',17),
('e3','c3',12),
('e4','c2',8),
('e1','c1',19),
('e5','c3',12),
('e4','c4',8),
('e5','c1',13);

INSERT INTO COURS VALUES 
('001','MAT1','PROF1'),
('002','MAT2','PROF2'),
('003','MAT3','PROF3'),
('004','MAT4','PROF4'),
('005','MAT5','PROF5');

INSERT INTO EXAMEN VALUES 
('e1','005',15.8),
('e2','004',17),
('e3','003',12),
('e4','002',8),
('e1','001',19),
('e5','003',12),
('e4','004',8),
('e5','001',13);

-- Questions
select "select e.* from ETUDIANT where 1 order by DateNaissance asc;" as "1 - Afficher la liste des étudiants triés par ordre croissant de date de naissance.";
select e.* from ETUDIANT e where 1 order by DateNaissance asc;

select "select e.* from ETUDIANT e where e.Niveau in ('M1', 'M2');" as "2 - Afficher tous les étudiants inscrits à M1 et tous les étudiants inscrits à M2.";
select e.* from ETUDIANT e where e.Niveau in ('M1', 'M2');

select "select e.Matricule from ETUDIANT e inner join EXAMEN ex on ex.Matricule=e.Matricule where ex.Code='002';" as "3 - Afficher les matricules des étudiants qui ont passé l'examen du cours 002";
select e.Matricule from ETUDIANT e inner join EXAMEN ex on ex.Matricule=e.Matricule where ex.Code='002';

select "select e.Matricule from ETUDIANT e inner join EXAMEN ex on ex.Matricule=e.Matricule where ex.Code in ('001', '002');" as "4 - Afficher les matricules de tous les étudiants qui ont passé l'examen du cours 001 et de tous
les étudiants qui ont passé l'examen du cours 002";
select e.Matricule from ETUDIANT e inner join EXAMEN ex on ex.Matricule=e.Matricule where ex.Code in ('001', '002');

select "select ex.* from EXAMEN ex where 1 order by ex.Matricule asc, ex.Code asc;" as "5 - Afficher le matricule, code, note /20 et note /40 de tous les examens classés par ordre
croissant de matricule et de code.";
select ex.* from EXAMEN ex where 1 order by ex.Matricule asc, ex.Code asc;

select "select ROUND(AVG(ex.Note),2) as Moyenne from EXAMEN ex where ex.Code='002' group by ex.Note;" as "6 -Trouver la moyenne de notes de cours 002.";
select ROUND(AVG(ex.Note),2) as Moyenne from EXAMEN ex where ex.Code='002' group by ex.Note;


select "select count(*) as Nb, ROUND(AVG(ex.Note),2) as Moyenne, ex.Matricule from EXAMEN ex where ex.Matricule = 'e1' group by ex.Matricule;" as "7 - Compter les examens passés par un étudiant (exemple avec matricule 'e1')";
select count(*) as Nb, ROUND(AVG(ex.Note),2) as Moyenne, ex.Matricule from EXAMEN ex where ex.Matricule = 'e1' group by ex.Matricule;

select "select count(*) as NB from EXAMEN ex where ex.Code='c1' group by ex.Code;" as "8 - Compter le nombre d'étudiants qui ont passé l'examen du cours 002.";
select count(*) as NB from EXAMEN ex where ex.Code='c1' group by ex.Code;

select "select count(*) as Nb, ROUND(AVG(ex.Note),2) as Moyenne, ex.Matricule from EXAMEN ex where ex.Matricule = 'e1' group by ex.Matricule;" as "9 - Calculer la moyenne des notes d'un étudiant (exemple avec matricule 'e1').";
select count(*) as Nb, ROUND(AVG(ex.Note),2) as Moyenne, ex.Matricule from EXAMEN ex where ex.Matricule = 'e1' group by ex.Matricule;

select "select e.*, ROUND(AVG(ex.Note),2) as Moyenne, count(*) as NB from EXAMEN ex inner join ETUDIANT e on ex.Matricule=e.Matricule group by ex.Matricule order by e.Nom asc;" as "10 + 11- Compter les examens = MOYENNE passés par chaque étudiant.";
select e.*, ROUND(AVG(ex.Note),2) as Moyenne, count(*) as NB from EXAMEN ex inner join ETUDIANT e on ex.Matricule=e.Matricule group by ex.Matricule order by e.Nom asc;

select "select e.*, ROUND(AVG(ex.Note),2) as Moyenne, count(*) as NB from EXAMEN ex inner join ETUDIANT e on ex.Matricule=e.Matricule group by ex.Matricule having Moyenne >= 15 order by e.Nom asc;" as "12 - La même au dessus, mais afficher seulement les étudiants (et leurs moyennes) dont la
moyenne est >= 15.";
select e.*, ROUND(AVG(ex.Note),2) as Moyenne, count(*) as NB from EXAMEN ex inner join ETUDIANT e on ex.Matricule=e.Matricule group by ex.Matricule having Moyenne >= 15 order by e.Nom asc;

select "select c.Code, c.NomCours, c.Enseignant, ROUND(AVG(ex.Note),2) as Moyenne from EXAMEN ex inner join COURS c on c.Code=ex.Code group by c.Code, c.NomCours, c.Enseignant;" as "13 - Trouver la moyenne de notes de chaque cours.";
select c.Code, c.NomCours, c.Enseignant, ROUND(AVG(ex.Note),2) as Moyenne from EXAMEN ex inner join COURS c on c.Code=ex.Code group by c.Code, c.NomCours, c.Enseignant;

