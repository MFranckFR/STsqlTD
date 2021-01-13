use sqltd4;

drop table if exists CUSTOMER,SUPPLIER,TRANSAC;
drop function if exists rand_1to;

create table CUSTOMER(
    Id int AUTO_INCREMENT PRIMARY KEY,
    FirstName varchar(50),
    LastName varchar(50),
    City varchar(50),
    Country varchar(50),
    Phone varchar(50)
);

create table SUPPLIER(
    id INT AUTO_INCREMENT PRIMARY KEY,
    CompanyName varchar(50),
    ContactName varchar(50),
    City varchar(50),
    Country varchar(50),
    Phone varchar(50),
    Fax varchar(50)
);

create table TRANSAC(
    id int AUTO_INCREMENT PRIMARY KEY,
    sup_id int,
    cust_id int,
    dt_debut DATETIME,
    dt_fin DATETIME
);

DELIMITER $$
create function rand_1to(i INT)
returns int 
NOT DETERMINISTIC
begin
    return 1 + ROUND(RAND()*(i - 1));
end$$
DELIMITER ;


insert into CUSTOMER values 
(NULL, 'Jo', 'Bi', 'Paris', 'France', '0102030405'),
(NULL, 'Donald', 'Trompette', 'Whashington', 'USA', '6677889922'),
(NULL, 'Jo', 'Bidon', 'New-York', 'USA', '8877665544'),
(NULL, 'Barak', 'Afrites', 'Lille', 'France', '0302030405'),
(NULL, 'Emmanuel', 'Commun', 'Paris', 'France', '0106030408');

insert into SUPPLIER values 
(NULL, 'Gogol', 'Sergueï Ch''Brin', 'Menio Park', 'USA',    '6688992625', '6688992625'),
(NULL, 'MacDonuts', 'Ronald Macdonuts', 'LouillesV', 'USA', '6622091692' , '6622091692'),
(NULL, 'Loréole', 'Jean-Paul Agar', 'Paris', 'France',      '0133686283', '0133686283'),
(NULL, 'Carrefort', 'Alexandre Bonparti', 'Massy', 'France', '0108776655', '0108776655'),
(NULL, 'Auchampignon', 'Gérard Mulot', 'Villeneuve d''Ascq', 'France', '0377665544', '0377665544');

insert into TRANSAC values
(NULL, rand_1to(5), rand_1to(5), '2020-01-01 08:00:00', '2020-01-02 10:11:00'),
(NULL, rand_1to(5), rand_1to(5), '2020-02-01 11:00:00', '2020-02-02 10:00:00'),
(NULL, rand_1to(5), rand_1to(5), '2020-01-01 08:00:00', '2020-01-02 10:11:00'),
(NULL, rand_1to(5), rand_1to(5), '2020-01-01 08:00:00', '2020-01-02 10:11:00'),
(NULL, rand_1to(5), rand_1to(5), '2020-01-01 08:00:00', '2020-01-02 10:11:00'),
(NULL, rand_1to(5), rand_1to(5), '2020-01-01 08:00:00', '2020-01-02 10:11:00'),
(NULL, rand_1to(5), rand_1to(5), '2020-01-01 08:00:00', '2020-01-02 10:11:00');

--
CREATE OR REPLACE VIEW t_all AS SELECT 
    c.FirstName,
    c.LastName,
    c.City,
    c.Country,
    s.CompanyName,
    s.ContactName,
    s.Country as c_Country,
    t.dt_debut,
    t.dt_fin
from TRANSAC t
    left outer join CUSTOMER c on c.id=t.cust_id
    right outer join SUPPLIER s on s.id=t.sup_id
where 1;

select "Liste toutes ces transactions" as "Creation vue sur toutes les transactions";
select * from t_all where 1;

select "select CompanyName, ContactName, c_Country as Country from t_all where FirstName is null;" as "Les compagnies sans client";
select CompanyName, ContactName, c_Country as Country from t_all where FirstName is null;

select "select FirstName, LastName, City from t_all where CompanyName is NULL;" as "Les clients sans Compagnie";
select FirstName, LastName, City from t_all where CompanyName is NULL;

select "select * from t_all where FirstName is not null and CompanyName is not null;" as "Toutes les transactions";
select * from t_all where FirstName is not null and CompanyName is not null;

