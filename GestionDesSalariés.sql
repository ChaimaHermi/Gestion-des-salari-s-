--Salaire de base 
Create table Salaire_base (
id_salaire_base number(6) CONSTRAINT id_salaire_base_pk PRIMARY KEY ,
salaire_base NUMBER(8,2) 

);

----table employee
CREATE TABLE employee
( id_employee NUMBER(6) CONSTRAINT id_employee_pk PRIMARY KEY,
nom VARCHAR2(20),
prenom VARCHAR2(25),
email VARCHAR2(25) CONSTRAINT email_emp NOT NULL ,
telephone VARCHAR2(20),
naissance DATE CONSTRAINT emp_naissance_1 NOT NULL,
Adresse varchar2(25),
id_salaire_base NUMBER(6), constraint id_salaire_base_fk FOREIGN KEY (id_salaire_base) references Salaire_base(id_salaire_base)

) ;
---table indemnit?
create table indemnites (
id_ind number(10) constraint id_ind_pk primary key ,
description varchar2(25),
montant float 
);



---table Maitre_paie
create table Maitre_paie (
id_MP number (6) constraint id_MP primary key ,
id_Employee NUMBER(6), constraint fk_id_employee FOREIGN KEY (id_employee) references employee(id_employee),
salaire_brut Number(6),
salaire_Net Number(6) 
);





---table detail_paie
create table detail_paie (
id_DP number (6) constraint id_DP_pk primary key ,
description varchar2(25),
montant float ,
id_MP NUMBER(6), constraint id_mp_fk FOREIGN KEY (id_MP) references Maitre_paie (id_MP)

);

---- insertions des informations 
insert into SALAIRE_BASE values (1,1200);
insert into SALAIRE_BASE values (2,3000);
insert into SALAIRE_BASE values (3,2000);
insert into SALAIRE_BASE values (4,1500);
insert into SALAIRE_BASE values (5,2500);


insert into employee values(1,'hermi','chaima','chaimahermi@gmail.com',54011315,'03/04/2001','jenoduba',2) ;
insert into employee values(2,'nefzi','emira','emiranefzi@gmail.com',53515210,'08/02/2001','Bhira',3) ;
insert into employee values(3,'maysen','chiha','maysenchiha@gmail.com',22310254,'04/03/2001','DarChaabenFehri',4) ;
insert into employee values(4,'sirine','berbibe','sirineberbibe@gmail.com',96212731,'09/05/2001','Jarzouna',5) ;
insert into employee values(5,'mayssa','benAzzouz','mayssaBenAzouz@gmail.com',96515430,'01/03/2001','Manzel abderahmen',1) ;
insert into employee values(6,'souha','boujneh','souhaboujneh@gmail.com',53414761,'05/05/2001','chaara',1) ;
insert into employee values(7,'nour','guesmi','geusmi nour@gmail.com',53313761,'05/05/2001','rassjbal',5) ;
insert into employee values(8,'foulen','fouleni','foulenflouni@gmail.com',54313761,'04/05/2001','rassjbal',4) ;



insert into INDEMNITES values (1,'transport',100);
insert into INDEMNITES values (2,'food',200);


delete from maitre_paie where id_mp=1 ;
delete from maitre_paie where id_mp=2 ;


declare 
indD VARCHAR2(25);
mont FLOAT ;
begin 
select description  into indD   from  indemnites ;
select MONTANT into mont from indemnites ;
insert into detail_paie values(5,indD,mont,5);


end ;


---packages 
create or replace NONEDITIONABLE PACKAGE PKG_SALARIES AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  function calcul_salaire (id in  number ) return float ;
  function calcul_salaire_brut (salaireBase in float )  return float ;
  function calcul_IRPP(salaire_brute in float ) return float ;
  function calcul_CNSS(salaire_brute in float ) return float ;
  
  

END PKG_SALARIES;


----body 
create or replace NONEDITIONABLE PACKAGE BODY PKG_SALARIES AS

  function calcul_salaire (id in NUMBER  ) return float  AS
    salaire_net float ;

  SBrut float ;  
  sbase float ;
   cnss float ;
    irpp float  ;

  
  BEGIN
    -- TODO : implémentation requise pour function PKG_SALARIES.calcul_salaire
    
  select salaire_base into sbase from salaire_base , employee 
   where  (salaire_base.id_salaire_base=employee.id_salaire_base) and (id_Employee=id) ;
   
   
 SBrut:=pkg_salaries.calcul_salaire_brut(sbase) ;
    cnss:=pkg_salaries.calcul_CNSS(SBrut) ;
  irpp:= pkg_salaries.calcul_IRPP(SBrut);
    
   salaire_net:= SBrut -irpp-cnss ;
    
   --  Maitre_paie 
   insert into Maitre_paie values (id,id,SBrut,salaire_net) ;

    RETURN salaire_net;
  END calcul_salaire;








  function calcul_salaire_brut (salaireBase in float )  return float  AS
  
    -- TODO : implémentation requise pour function PKG_SALARIES.calcul_salaire_brut
Mind INDEMNITES.Montant%type;   
salaireBrut float ;
BEGIN
select Montant into Mind  from INDEMNITES where id_ind=2 ;

salaireBrut:=salaireBase+Mind ;


--insert  into Maitre_paie (Salaire_brut) values(salaireBrut) ; manajmch khater bch taati valeur null le les colonnes lokhrin
return salaireBrut ;
    
END calcul_salaire_brut;




  function calcul_IRPP(salaire_brute in float ) return float  AS
   irpp float ;
  BEGIN
    -- TODO : implémentation requise pour function PKG_SALARIES.calcul_IRPP
    
  irpp:=salaire_brute*0.28 ;
    
  return irpp ;
  END calcul_IRPP;

  function calcul_CNSS(salaire_brute in float ) return float  AS
   cnss float ;
  BEGIN
    -- TODO : implémentation requise pour function PKG_SALARIES.calcul_CNSS
      cnss:=salaire_brute*0.0918;

    
    
    return cnss ;
  END calcul_CNSS;

END PKG_SALARIES;


















---execution finale <3 hamdoulaaaaaaaaaaaaaaaaaaaaaaaah ye rabyyy  03:49 h de matin <3 

declare 
test float ;
begin

test:=pkg_salaries.calcul_salaire(2);

end ;
declare 
test float ;
begin

test:=pkg_salaries.calcul_salaire(1);

end ;



test:=pkg_salaries.calcul_salaire(4);

end ;






declare 
test float ;
begin

test:=pkg_salaries.calcul_salaire(5);

end ;


declare 
test float ;
begin

test:=pkg_salaries.calcul_salaire(8);

end ;



test:=pkg_salaries.calcul_salaire(4);

end ;







