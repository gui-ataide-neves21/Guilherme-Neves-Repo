CREATE SCHEMA IF NOT EXISTS project_GroupM; 

USE project_GroupM;

CREATE TABLE IF NOT EXISTS `Products` (
  `PRODUCT_ID` INTEGER NOT NULL,
  `PRODUCT_TYPE` varchar(40) NOT NULL,
  `BRAND` varchar(40) DEFAULT NULL,
  `MODEL` varchar(40)  DEFAULT NULL,
  `COLOR` varchar(20) DEFAULT NULL,
  `SIZE` INTEGER DEFAULT NULL,
  `STORAGE` INTEGER DEFAULT NULL,
  `PRICE` INTEGER NOT NULL,
  `STOCK` INTEGER(4) UNSIGNED NOT NULL,
  `RATING` INTEGER DEFAULT NULL ,
  `DISCOUNT` FLOAT NOT NULL,
  `TAXRATE` FLOAT NOT NULL,
  PRIMARY KEY (`PRODUCT_ID`)
);



CREATE TABLE IF NOT EXISTS `Role` (
  `ROLE_ID` INTEGER NOT NULL,
  `ROLE_TITLE` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ;


CREATE TABLE IF NOT EXISTS `Department` (
  `DEPARTMENT_ID` INTEGER NOT NULL,
  `DEPARTMENT_NAME` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`)
);



CREATE TABLE IF NOT EXISTS `Employee` (
  `EMPLOYEE_ID` INTEGER NOT NULL,
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(25) DEFAULT NULL,
  `EMAIL` varchar(40) NOT NULL,
  `PHONE_NUMBER` varchar(20) DEFAULT NULL,
  `HIRE_DATE` date NOT NULL,
  `ROLE_ID` INTEGER NOT NULL,
  `SALARY` decimal(8,2) DEFAULT NULL,
  `DEPARTMENT_ID` INTEGER NOT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  FOREIGN KEY (`DEPARTMENT_ID`)
	REFERENCES `Department`(`DEPARTMENT_ID`)
	ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (`ROLE_ID`)
	REFERENCES `Role`(`ROLE_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ;



CREATE TABLE IF NOT EXISTS `Client_Account` (
`CLIENT_ID` INTEGER NOT NULL,
`FIRST_NAME` varchar(20) Not NULL,
`LAST_NAME` varchar(25) Default NULL,
`DATE_OF_BIRTH` date NOT NULL,
`EMAIL` varchar(40) NOT NULL,
`NIF`varchar(20) DEFAULT NULL,
`PHONE_NUMBER` varchar(20) DEFAULT NULL,
`ADRESS` varchar(60) DEFAULT NULL,
`ZIP_CODE` varchar(10) DEFAULT NULL,
`LOCATION` varchar(20) DEFAULT NULL,
`COUNTRY` varchar(20) DEFAULT NULL,
`PASSWORD` varchar(20) NOT NULL,
`CATEGORY` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CLIENT_ID`)
) ;


CREATE TABLE IF NOT EXISTS `Payment_Method` (
`PAYMENT_ID` INTEGER NOT NULL,
`METHOD_ID` INTEGER NOT NULL,
  PRIMARY KEY (`PAYMENT_ID`, `METHOD_ID`)
  ) ; 


  CREATE TABLE IF NOT EXISTS `Credict_Card` (
`CREDICT_ID` INTEGER NOT NULL,
`METHOD_ID` INTEGER NOT NULL,
`CARD_NAME` varchar(20) DEFAULT NULL,
`CARD_NUMBER` varchar(20) NOT NULL,
`VALIDATION_DATE` varchar(10) NOT NULL,
`CCV` varchar(3) NOT NULL,
  PRIMARY KEY (`CREDICT_ID`),
  CONSTRAINT `METHOD_ID_C`
    FOREIGN KEY (`METHOD_ID`)
    REFERENCES `payment_method` (`PAYMENT_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    );
  
    CREATE TABLE IF NOT EXISTS `Paypal` (
`PAYPAL_ID` INTEGER NOT NULL,
`METHOD_ID` INTEGER NOT NULL,
`PAYPAL_EMAIL` varchar(40) NOT NULL,
`PAYPAL_PASS` varchar(20) NOT NULL,
  PRIMARY KEY (`PAYPAL_ID`),
  CONSTRAINT `METHOD_ID_P`
    FOREIGN KEY (`METHOD_ID`)
    REFERENCES `payment_method` (`PAYMENT_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    );


CREATE TABLE IF NOT EXISTS `Order` (
`ORDER_ID` INTEGER NOT NULL,
`PAYMENT_ID` INTEGER NOT NULL,
`CLIENT_ID` INTEGER NOT NULL,
`SHIPPING_ADRESS` varchar(40) NOT NULL,
`SHIPPING_LOCATION` varchar(40) NOT NULL,
`DATE_ORDER` DATE NOT NULL,
`INVOICE_NUMBER`INTEGER NOT NULL,
  PRIMARY KEY (`ORDER_ID`),
  FOREIGN KEY (`PAYMENT_ID`)
	REFERENCES `Payment_Method`(`PAYMENT_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (`CLIENT_ID`)
	REFERENCES `Client_Account`(`CLIENT_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
  );
  

CREATE TABLE IF NOT EXISTS `Shipment` (
`SHIPMENT_ID` INTEGER NOT NULL,
`ORDER_ID` INTEGER NOT NULL,
`TRACKING_NUMBER` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SHIPMENT_ID`),
  constraint `Order id`
	FOREIGN KEY (`ORDER_ID`)
	REFERENCES `Order`(`ORDER_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
  ) ;
  
  
  
CREATE TABLE IF NOT EXISTS `Products_Ordered` (
`ORDER_ID` INTEGER NOT NULL,
`PRODUCT_ID` INTEGER NOT NULL,
`QUANTITY` INTEGER NOT NULL DEFAULT 0,
FOREIGN KEY (`ORDER_ID`)
	REFERENCES `Order`(`ORDER_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
FOREIGN KEY (`PRODUCT_ID`)
	REFERENCES `Products`(`PRODUCT_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
  ) ;
  
  
  Insert into `Products` (`PRODUCT_ID`,`PRODUCT_TYPE`,`BRAND`,`MODEL`,`COLOR`,`SIZE`,`STORAGE`,`PRICE`,`STOCK`, `RATING`, `DISCOUNT`, `TAXRATE`) values
(1257019, 'Smartphone', 'APPLE', ' IPHONE 12','Green', 6.1, 64, 899, 21,5, 0.2,0.23),
(2257019, 'Smartphone', 'SAMSUNG', 'GALAXY S20','Orange', 6.5, 128, 649, 21,null,0,0.23),
(3257019, 'Smartphone', 'HUAWEI', 'P SMART 2020','Green', 6.21, 128, 169, 21,null,0.10,0.23),
(4257019, 'Tablet', 'SAMSUNG', ' GALAXY TAB S6 LITE','Blue', 10.4, 128, 439, 5, 4,0.4,0.23),
(5257019, 'Tablet', 'SAMSUNG', 'GALAXY TAB S6 LITE','Black', 10.4, 64, 369, 5,3,0,0.23),
(6257019, 'Tablet', 'HUAWEI', 'HUAWEI MATEPAD','Black', 10.1, 32, 179, 5,3,0.30,0.23),
(5357019, 'Accessory','SAMSUNG', 'EB-P1100B 10000','Grey',null,null, 30, 2,null,0,0.23),
(6357019, 'Accessory','APPLE', 'AIRPODS 2019','White',null,null, 178, 2, 5,0,0.23),
(7257019, 'Accessory','APPLE', 'AIRPODS 2019','Black',null,null, 178, 2,5,0.15,0.23),
(8257019, 'Accessory','APPLE', '12 PRO MAX','Black',null,null, 23, 2,5,0.25,0.23),
(9257019, 'Accessory','HUAWEI ', 'P40 LITE','Transparent',null,null, 13, 2, 4,0,0.23),
(1012570, 'Accessory','SAMSUNG', 'GALAXY J3','Transparent',null,null, 10, 2,4,0.2,0.23),
(1112570, 'Accessory','SAMSUNG', 'GALAXY J45','Transparent',null,null, 30, 2,4,0.5,0.23),
(1212570, 'Accessory','SAMSUNG', 'GALAXY EB-P1100B 10000','Pink',null,null, 30, 2,null,0,0.23), 
(1312570, 'Accessory','SAMSUNG', 'GALAXY EB-P1100B 10000','Red',null,null, 30, 2,2,0,0.23), 
(1412570, 'Smartphone', 'APPLE', 'IPHONE 11 Pro','Grey', 6.1, 64, 999, 10,null,0.5,0.23),
(1512570, 'Smartphone', 'SAMSUNG', 'GALAXY S20','Black', 6.5, 128, 649, 10,5,0.1,0.23),
(1612570,'Smartphone', 'HUAWEI', 'P SMART 2020','Gold', 6.21, 128, 169, 10,3,0,0.23),
(1712570, 'Tablet', 'SAMSUNG', 'GALAXY TAB S6 LITE','White', 10.4, 128, 439, 8,4,0,0.23),
(1812570, 'Tablet', 'SAMSUNG', 'GALAXY TAB S6 LITE','White', 10.4, 64, 369, 8,4,0.5,0.23),
(1912570, 'Tablet', 'HUAWEI', 'HUAWEI MATEPAD','Blue', 10.1, 32, 179, 8,5,0.1,0.23),
(2012570, 'Tablet', 'SAMSUNG', 'GALAXY TAB S6 LITE','Grey', 10.4, 32, 309, 8, null,0,0.23), 
(2112570, 'Tablet', 'HUAWEI', 'TAB MATEPAD','Grey', 10.4, 32, 309, 8,4,0.20,0.23),
(2212570, 'Smartphone', 'APPLE', 'IPHONE 7','Gold', 4.7, 64, 349, 3,4,0,0.23),
(2312570, 'Smartphone', 'APPLE', 'IPHONE 7','White', 4.7, 32, 349, 3,4,0,0.23),
(2412570, 'Smartphone', 'SAMSUNG', 'GALAXY A21s','Blue', 6.5, 64, 209, 3,2,0,0.23),
(2512570, 'Smartphone', 'HUAWEI', 'Y5 2019','Blue', 5.71, 16, 109, 3,4,0,0.23);


Insert into `Role` (`ROLE_ID`, `ROLE_TITLE`) Values
(1, 'Web Developer'),
(2, 'Warehouse Manager'),
(3, 'Warehouse Employee'),
(4, 'Marketeer'),
(5, 'Phone Operator'),
(6, 'CEO'),
(7, 'Sales Manager'),
(8,'Social Media Manager'),
(9, 'SEO Manager'),
(10, 'eCommerce Marketing Analyst'),
(11, 'IT technician'),
(12, 'Client Services Support'),
(13, 'Accountant');


Insert into `Department` (`DEPARTMENT_ID`, `DEPARTMENT_NAME`) Values
(1, 'Logistic'),
(2, 'Marketing'),
(3, 'Sales'),
(4, 'IT'),
(5, 'Customer Service'),
(6, 'Accounting');


Insert into `Employee` (`employee_id`, `first_name`, `last_name`, `email`, `PHONE_NUMBER`, `HIRE_DATE`, `ROLE_ID`, `SALARY`, `DEPARTMENT_ID`) values
(1, 'Daniel', 'Jesus', 'dj@gmail.com', '921234567', '2015-01-23', 1, 1500, 4),
(2, 'Micaela', 'Sousa', 'ms@gmail.com', '923456789','2015-01-23',2, 1500, 1),
(3, 'Marta', 'Fernandes', 'mf@gmail.com', '924567891', '2015-01-23',3, 900, 1),
(4, 'Bruna', 'Gonçalves', 'bg@outlook.pt', '925678912', '2015-01-23',3,900, 1),
(5, 'Bruno', 'Gomes', 'bg@gmail.com', '926789123','2017-06-10',3, 900, 1),
(6, 'Gustavo', 'Lopes', 'gl@outlook.pt', '927891234','2017-06-10', 3, 900, 1),
(7, 'Inês', 'Marques', 'im@outlook.pt', '928912345', '2015-01-23', 4, 1500, 2),
(8, 'Ricardo', 'Alves', 'ricardo.a@gmemployeeail.com', '929123456', '2015-01-23', 5, 900, 5),
(9, 'Filipe', 'Almeida', 'fa@gmail.com', '912345678', '2015-01-23', 6,3000, 1),
(10, 'Helena', 'Ribeiro', 'hrs@outlook.pt', '912345679', '2015-01-23', 7,1500,3),
(11, 'Paulo', 'Pinto', 'paulo.pinto@outlook.pt', '912345670','2015-01-23',8, 1000, 2),
(12, 'João', 'Carvalho', 'joaocarvalho@gmail.com', '912345677', '2015-01-23', 9, 3000, 1),
(13, 'Amélia', 'Teixeira', 'amtex@gmail.com',  '912345676', '2015-01-23', 10, 1500,2),
(14, 'António', 'Moreira', 'am@gmail.com', '912345675', '2015-01-23', 11, 900, 4),
(15, 'Manuel', 'Correia', 'mc@outlook.pt', '912345674','2015-10-23', 12 , 1500, 5),
(16, 'Beatriz', 'Mendes', 'biamen@gmail.com',  '912345673', '2015-10-23', 13, 1500,  6),
(17, 'Ana', 'Nunes', 'ana.nunes@outlook.pt', '912345672','2017-06-10', 11,900,  1);

INSERT INTO `Client_Account` (`CLIENT_ID`, `FIRST_NAME`, `LAST_NAME`, `DATE_OF_BIRTH`, `EMAIL`, `NIF`, `PHONE_NUMBER`, `ADRESS`, `ZIP_CODE`, `LOCATION`, `COUNTRY`, `PASSWORD`) VALUES
(1, 'Carolina', 'Loureiro', '1990-05-23', 'carol_lou@gmail.com', '234657879', '925418025', 'Rua Doutor Artur Alves Moreira Urbanização Carramona','3800-009', 'Aveiro','Portugal', '*****'),
(2, 'Pedro', 'Ortigão', '1997-07-07', 'pedrocas.97@gmail.com', '985643865', '967176177','Rua João Villaret','1000-182', 'Lisboa','Portugal','*****'),
(3, 'Paulo', 'Nunes', '1961-10-19', 'paulo.nunes@gmail.com', '861263769', '963831332', 'Avenida Sacadura Cabral','1000-270', 'Lisboa', 'Portugal','*****'),
(4, 'Alexandra', 'Silva', '1972-09-18', 'alex_silve@outlook.pt', '230230034', '915454180', 'Rua 1 de Abril','3040-589','Coimbra', 'Portugal','*****'),
(5, 'Bruna', 'Rodrigues', '1967-04-21', 'bruna_rodrigues@gmail.com', '565687909', '915190213','Rua 1 de Maio','3040-771', 'Coimbra', 'Portugal','*****'),
(6, 'Alice', 'Vieira', '1965-01-02', 'alice.vi@outlook.pt', '198706175', '910346176','Rua do Brasil', '3030-175', 'Coimbra', 'Portugal','*****'),
(7, 'Luís', 'Fragoso', '1983-07-04', 'fragas.luis@outlook.pt', '195606189', '964124051', 'Rua do Areeiro', '3810-823', 'Aveiro', 'Portugal','*****'),
(8, 'Ricardo', 'Martins', '1971-03-29', 'ricardo.mrt@gmail.com', '980739875', '915041587', 'Rua Heróis de Mucaba', '4100-279', 'Porto', 'Portugal','*****'),
(9, 'Filipe', 'Dias', '1983-11-17', 'pipo.dias.83@gmail.com', '375864920', '923465789', 'Rua La Couture', '4200-361','Porto', 'Portugal','*****'),
(10, 'Carla', 'Santos', '1992-02-14', 'carlinha.santos@outlook.pt', '19870621', '965438798', 'Rua Cidade Liverpool', '1199-009','Lisboa', 'Portugal','*****'),
(11, 'Paulo', 'Rocha', '1980-06-20', 'paulo.vet@outlook.pt', '173546278', '917659872', 'Avenida Praia da Vitória', '1068-00','Lisboa', 'Portugal','*****'),
(12, 'João', 'Pires', '1999-02-28', 'joao.pires.99@gmail.com', '464642596', '916768199', 'Praça de Alvalade', '1748-00', 'Lisboa', 'Portugal','*****'),
(13, 'Catarina', 'Afonso', '1990-05-07', 'cata.afonso@gmail.com', '728346578', '910234654', 'Rua Vale Formoso', '1959-004', 'Lisboa', 'Portugal','*****'),
(14, 'Leonor', 'Rosas', '1978-11-10', 'leo.rosas@gmail.com', '839485762', '916767982', 'Rua Doutor Fonseca de Almeida', '8401-853','Lagoa', 'Portugal','*****'),
(15, 'Nuno', 'Pais', '1989-08-30', 'pais.nuno.89@outlook.pt', '2634518909', '923476980','Rua de São Geraldo', '4704-537','Braga', 'Portugal','*****'),
(16, 'Tiago', 'Sousa', '1998-08-15', 'tigs.sousa@gmail.com', '719254098', '938080806', 'Rua Fernando Caldeira', '3754-501',  'Águeda', 'Portugal','*****'),
(17, 'Ana', 'Monteiro', '1955-09-16', 'ana.monteiro@outlook.pt', '515243526', '915779327','Rua João de Deus', '3515-173',  'Viseu', 'Portugal','*****'),
(18, 'Madalena', 'Pinto', '1950-04-27', 'mada.pinto@outlook.pt', '908978675', '923765810','Rua dos Ameixoeiras Gulpilhares','4405-615','Vila Nova de Gaia', 'Portugal','*****'),
(19, 'Maria', 'Santos', '1969-12-16', 'mary.santos@outlook.pt', '122323234', '912343612','Praceta Alves Redol', '2004-007','Santarém', 'Portugal','*****'),
(20, 'Rui', 'Neves', '1966-12-01', 'neves.rui@outlook.pt', '200377698', '920007655', 'Travessa Forno do Maldonado', '1100-254','Lisboa', 'Portugal','*****'),
(21, 'Mariana', 'Henriques', '1999-11-25', 'mary.99@gmail.com', '855734456', '967879144', 'Rua Nova do Alquebe Quinta do Picado',' 3810-479', 'Aveiro', 'Portugal','*****'),
(22, 'Rodrigo', 'Lopes', '1997-01-12', 'rodrigo.lopes.97@gmail.com', '900787890', '925418026',  'Rua Gago Coutinho','3830-669','Gafanha da Nazaré', 'Portugal','*****'),
(23, 'Rita', 'Azevedo', '1967-04-24', 'aritazevedo@gmail.com', '191817165', '926689892','Rua da Madalena', '5155-002', 'Cedovim', 'Portugal','*****'),
(24, 'Guilherme', 'Silva', '1976-10-08', 'gui.silva@outlook.pt', '564324165', '912564564','Vale Dado', '7800-102','Beja', 'Portugal','*****'),
(25, 'João', 'Seabra', '1980-06-03', 'joao.s.80@gmail.com', '981762543', '912678453','Rua de Damão', '4454-503', 'Matosinhos', 'Portugal','*****');

INSERT INTO `Payment_method` (`PAYMENT_ID`, `METHOD_ID`) VALUES 
(1, 2),
(2, 2),
(3, 1),
(4, 2),
(5, 1),
(6, 1),
(7, 1),
(8, 2),
(9, 2),
(10, 1),
(11, 2),
(12, 2),
(13, 1),
(14, 2),
(15, 1),
(16, 1),
(17, 1),
(18, 2),
(19, 2),
(20, 1),
(21, 2),
(22, 2),
(23, 1),
(24, 2),
(25, 1);

INSERT INTO `Credict_card` (`CREDICT_ID`, `CARD_NAME`, `CARD_NUMBER`, `VALIDATION_DATE`, `CCV`, `METHOD_ID`) VALUES 
(1, 'João Gomes', '1234 5678 9876 5432', '07/21', '178',1),
(2, 'Francisca Caetano', '5678 5448 8966 5142', '04/23', '211',1),
(3, 'Fernanda Silva', '9746 5477 8216 1332', '10/23', '139',1),
(4, 'Jaime Pires', ' 5247 7746 8886 1365', '12/22', '305',1),
(5, 'Roberto Vieira', '4346 5336 6916 5532', '01/25', '409',1),
(6, 'Joana Rita', '5678 5434 3376 4432', '02/21', '248',1),
(7, 'Francisco Campos', '5644 7748 8916 5332', '01/23', '297',1),
(8, 'Silvia Fernandes', '7643 6477 5489 1362', '04/23', '415',1),
(9, 'Maria Vieira', ' 6597 2369 8886 4488', '11/21', '445',1),
(10, 'Ana Moura', '5745 3641 7814 6622', '01/24', '321',1),
(11, 'Nuno Quaresma', '4451 6233 4877 5122', '04/22', '145',1),
(12, 'Rui Caetano', '1442 4622 4788 5142', '09/23', '251',1),
(13, 'Fernando Pinto', '4855 2563 4213 7944', '07/23', '147',1);

INSERT INTO `Paypal` (`PAYPAL_ID`, `PAYPAL_EMAIL`, `PAYPAL_PASS`,`METHOD_ID`) VALUES 
(1, 'ronaldo7@gmail.com', 'ronaldo7thebest',2),
(2, 'francisco78@gmail.com', 'francisco78silva',2),
(3, 'gonçalo1999@gmail.com', 'gonçaloscp99',2),
(4, 'ricardo_henriques@gmail.com', 'henriques07',2),
(5, 'ritamaria96@gmail.com', 'rmaria96',2),
(6, 'joao_mario@hotmail.com', 'joao77marioscp',2),
(7, 'antonio1234@gmail.com', 'antonio00fernandes',2),
(8, 'barbara1978@hotmail.com', 'bmartins1978',2),
(9, 'andreia_cruz@gmail.com', 'cruz87567',2),
(10, 'pedro_mendes6@gmail.com', 'pmendes621',2),
(11, 'kvd_2001@gmail.com', '2001_kvd_2001',2),
(12, 'carolina_c77@hotmail.com', '19carolina_c77',2);


INSERT INTO `Order` (`ORDER_ID`,`PAYMENT_ID`,`CLIENT_ID`,`SHIPPING_ADRESS`, `SHIPPING_LOCATION`, `DATE_ORDER`, `INVOICE_NUMBER`) VALUES
(1, 1,5,'Avenida Escolas 21','Lisboa','2015-05-08', 53467),
(2, 2,2,'Avenida Miguel Bombarda 65','Porto','2015-09-17',87645),
(3, 3,3,'Rua Capela 33','Santarém','2015-10-03',87345),
(4, 4,4,'Rua Cortinhas Fonte 65','Leiria','2015-11-28',56342),
(5, 5,5,'Rua Longuinha 81','Coimbra','2015-12-18',54321),
(6, 6,6,'Avenida Francelos 41','Viseu','2016-06-14',65287),
(7, 7,7,'Rua Tapada Marinha 80','Leiria','2016-07-13',98231),
(8, 8,8,'Rua Padre António Vieira 56','Porto','2016-05-08',48930),
(9, 9,9,'Bairro St António 97','Braga','2016-08-25',72364),
(10, 10,10,'Avenida da Liberdade 111','Aveiro','2017-03-25',90129),
(11, 11,11,'Avenida de Roma 35','Pombal','2017-04-25',87898),
(12, 12,6,'Avenida Almirante Reis 22','Coimbra','2017-03-28',25344),
(13, 13,13,'Travessa Choupelo 110','Lisboa','2017-07-05',12115),
(14, 14,4,'Rua Augusta 23','Alverca','2017-09-02',38265),
(15, 15,5,'Rua 1º Dezembro 25','Torres Vedras','2018-03-28',67542),
(16, 16,16,'Avenida Escolas 21','Torres Novas','2018-12-28',12345),
(17, 17,17,'Rua Longuinha 81','Santarém','2018-12-29',98765),
(18, 18,18,'Rua Padre António Vieira 56','Porto','2019-04-01',97531),
(19, 19,9,'Rua Tapada Marinha 80','Braga','2019-06-11',24680),
(20, 20,20,'Avenida Miguel Bombarda 25','Aveiro','2020-03-01',08531),
(21, 21,21,'Rua Cortinhas Fonte 55','Porto','2020-04-16',34286),
(22, 22,22,'Avenida Escolas 20','Lisboa','2020-05-15',25167),
(23, 23,23,'Avenida Escolas 22','Coimbra','2020-06-22',12169),
(24, 24,4,'Rua Conde Redondo 34','Lisboa','2020-07-13',13121),
(25, 25,5,'Avenida da República 20','Porto','2020-08-15',23432);

Insert into `Shipment` (`SHIPMENT_ID`, `ORDER_ID`, `TRACKING_NUMBER`) Values
(1, 2,'131516258595'),
(2, 3 ,'174643729202'),
(3, 4,'756399722484'),
(4, 1,'747455688928'),
(5, 5,'853838464215'),
(6, 9,'494759053521'),
(7, 8,'462412274950'),
(8, 6,'483664531033'),
(9, 7,'127846304693'),
(10, 15,'485874563428'),
(11, 11,'494740304564'),
(12, 12,'396453428111'),
(13, 10,'394765489402'),
(14, 14,'569673421489'),
(15, 13,'163438494953'),
(16, 22,'859353839001'),
(17, 23,'857649493532'),
(18, 19,'393928711236'),
(19, 16,'856535424271'),
(20, 21,'942718156300'),
(21, 20,'745241718911'),
(22, 17,'634171910833'),
(23, 18,'846492162422'),
(24, 25,'637383092011'),
(25, 24,'235374849201');
 
Insert into `Products_Ordered` (`ORDER_ID`, `PRODUCT_ID`, `QUANTITY`) Values
(1, 2512570, 2),
(2, 2412570, 1),
(1, 2412570, 1),
(3, 2512570, 2),
(4, 1257019, 1),
(5, 2312570, 3),
(6, 2312570, 1),
(4, 3257019, 3),
(4, 8257019, 1),
(7, 3257019, 2),
(9, 2512570, 4),
(8, 9257019, 2),
(9, 1612570, 1),
(13, 1612570, 1),
(11, 8257019, 1),
(12, 3257019, 2),
(10, 2112570, 1),
(10, 9257019, 1),
(14, 2012570, 2),
(17, 2012570, 3),
(15, 1257019, 1),
(14, 1612570, 1),
(16, 3257019, 1),
(19, 8257019, 2),
(18, 2312570, 3),
(25, 3257019, 1),
(20, 1257019, 1),
(21, 1912570, 4),
(22, 1912570, 1),
(22, 2112570, 2),
(24, 1712570, 1),
(23, 3257019, 1),
(23, 1612570, 3),
(22, 9257019, 1),
(22, 3257019, 1);



CREATE TABLE IF NOT EXISTS `New_Clients` (
`New_ClientsID` INTEGER NOT NULL AUTO_INCREMENT,
`customer_name` VARCHAR(40) NULL,
`Age` INTEGER NOT NULL,
`spending score (1-100)` INTEGER NOT NULL,
`Email` VARCHAR(60) NOT NULL,
`spending category` VARCHAR(15) NOT NULL,
PRIMARY KEY (`New_ClientsID`)
) ;