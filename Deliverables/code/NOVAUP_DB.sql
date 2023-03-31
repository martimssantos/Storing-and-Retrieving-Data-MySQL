-- -----------------------------------------------------
-- Schema novaup
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `novaup` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `novaup` ;

-- -----------------------------------------------------
-- Table `novaup`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`location` (
  `id_location` VARCHAR(20) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_location`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `novaup`.`gym`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`gym` (
  `id_gym` VARCHAR(20) NOT NULL,
  `gym_name` VARCHAR(45) NOT NULL,
  `ID_LOCATION` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_gym`),
  INDEX `fk_gym_location1_idx` (`ID_LOCATION` ASC) VISIBLE,
  CONSTRAINT `fk_gym_location1`
    FOREIGN KEY (`ID_LOCATION`)
    REFERENCES `novaup`.`location` (`id_location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `novaup`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`department` (
  `id_department` VARCHAR(20) NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_department`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `novaup`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`employee` (
  `id_employee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `birth_year` INT NOT NULL,
  `cc` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `ID_GYM` VARCHAR(20) NOT NULL,
  `job` VARCHAR(45) NOT NULL,
  `income_per_year` VARCHAR(45) NOT NULL,
  `ID_DEPARTMENT` VARCHAR(20) NOT NULL,
  `first_year` INT NOT NULL,
  PRIMARY KEY (`id_employee`),
  INDEX `fk_employee_gym1_idx` (`ID_GYM` ASC) VISIBLE,
  INDEX `fk_employee_department1_idx` (`ID_DEPARTMENT` ASC) VISIBLE,
  CONSTRAINT `fk_employee_gym1`
    FOREIGN KEY (`ID_GYM`)
    REFERENCES `novaup`.`gym` (`id_gym`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_department1`
    FOREIGN KEY (`ID_DEPARTMENT`)
    REFERENCES `novaup`.`department` (`id_department`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `novaup`.`classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`classes` (
  `id_classes` VARCHAR(20) NOT NULL,
  `classes_name` VARCHAR(45) NOT NULL,
  `ID_EMPLOYEE` INT NOT NULL,
  `openings` INT NOT NULL,
  PRIMARY KEY (`id_classes`),
  INDEX `fk_classes_employee1_idx` (`ID_EMPLOYEE` ASC) VISIBLE,
  CONSTRAINT `fk_classes_employee1`
    FOREIGN KEY (`ID_EMPLOYEE`)
    REFERENCES `novaup`.`employee` (`id_employee`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `novaup`.`plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`plans` (
  `id_plan` VARCHAR(20) NOT NULL,
  `plan_name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  `has_group_classes` TINYINT NOT NULL COMMENT '1 - yes or 0 - no',
  `has_pool` TINYINT NOT NULL COMMENT '1 - yes or 0 - no',
  `has_shower` TINYINT NOT NULL COMMENT '1 - yes or 0 - no',
  `has_nutri_evaluation` TINYINT NOT NULL COMMENT '1 - yes or 0 - no',
  `has_pt` TINYINT NOT NULL COMMENT '1 - yes or 0 - no',
  PRIMARY KEY (`id_plan`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `novaup`.`promotions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`promotions` (
  `id_promotions` VARCHAR(20) NOT NULL,
  `promo_name` VARCHAR(45) NOT NULL,
  `discount` FLOAT NOT NULL,
  PRIMARY KEY (`id_promotions`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `novaup`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`customer` (
  `id_customer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `birth_year` YEAR NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `phone_number` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `cc` VARCHAR(45) NOT NULL,
  `first_day` DATE NOT NULL,
  `ID_GYM` VARCHAR(20) NOT NULL,
  `ID_PLAN` VARCHAR(20) NOT NULL,
  `ID_PROMOTIONS` VARCHAR(20) NOT NULL,
  `method_name` VARCHAR(20) NOT NULL, 
  `account_number` BIGINT NOT NULL,
  PRIMARY KEY (`id_customer`),
  INDEX `fk_customer_promotions_idx` (`ID_PROMOTIONS` ASC) VISIBLE,
  INDEX `fk_customer_plans1_idx` (`ID_PLAN` ASC) VISIBLE,
  INDEX `fk_customer_gym1_idx` (`ID_GYM` ASC) VISIBLE,
  CONSTRAINT `fk_customer_plans1`
    FOREIGN KEY (`ID_PLAN`)
    REFERENCES `novaup`.`plans` (`id_plan`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_promotions`
    FOREIGN KEY (`ID_PROMOTIONS`)
    REFERENCES `novaup`.`promotions` (`id_promotions`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_gym1`
    FOREIGN KEY (`ID_GYM`)
    REFERENCES `novaup`.`gym` (`id_gym`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `novaup`.`is_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`is_student` (
  `id_promotions` VARCHAR(20) NOT NULL,
  `id_customer` INT NOT NULL,
  PRIMARY KEY (`id_promotions`, `id_customer`),
  INDEX `fk_is_student_member1_idx` (`id_customer` ASC) VISIBLE,
  CONSTRAINT `fk_is_student_member1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `novaup`.`customer` (`id_customer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_is_student_promotions1`
    FOREIGN KEY (`id_promotions`)
    REFERENCES `novaup`.`promotions` (`id_promotions`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `novaup`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`payment` (
  `id_payment` INT NOT NULL AUTO_INCREMENT,
  `ID_CUSTOMER` INT NOT NULL,
  `payment_date` DATE NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_payment`),
  INDEX `fk_payment_customer1_idx` (`ID_CUSTOMER` ASC) VISIBLE,
  CONSTRAINT `fk_payment_customer1`
    FOREIGN KEY (`ID_CUSTOMER`)
    REFERENCES `novaup`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `novaup`.`classes_attendences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`classes_attendences` (
  `id_classes` VARCHAR(20) NOT NULL,
  `id_customer` INT NOT NULL,
  PRIMARY KEY (`id_classes`, `id_customer`),
  INDEX `fk_classes_attendences_classes1_idx` (`id_classes` ASC) VISIBLE,
  INDEX `fk_classes_attendences_costumer1_idx` (`id_customer` ASC) VISIBLE,
  CONSTRAINT `fk_classes_attendences_classes1_classes1`
    FOREIGN KEY (`id_classes`)
    REFERENCES `novaup`.`classes` (`id_classes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_classes_attendences_customer1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `novaup`.`customer` (`id_customer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `novaup`.`phone_changes` (
  `ID_CUSTOMER` INT NOT NULL,
  `date_of_change` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `old_phone_number` INT NOT NULL,
  `new_phone_number` INT NOT NULL,
  PRIMARY KEY (`ID_CUSTOMER`),
  INDEX `fk_log_customer1_idx` (`ID_CUSTOMER` ASC) VISIBLE,
  CONSTRAINT `fk_log_customer1`
    FOREIGN KEY (`ID_CUSTOMER`)
    REFERENCES `novaup`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `novaup`.`ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `novaup`.`ratings` (
  `id_ratings` VARCHAR(20) NOT NULL,
  `ID_CUSTOMER` INT NOT NULL,
  `ID_PLAN` VARCHAR(20) NOT NULL,
  `rating` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_ratings`),
  INDEX `fk_ratings_customer1_idx` (`ID_CUSTOMER` ASC) VISIBLE,
  CONSTRAINT `fk_ratings_customer1`
    FOREIGN KEY (`ID_CUSTOMER`)
    REFERENCES `novaup`.`customer` (`id_customer`)
	ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- TRIGGERS
-- TRIGGERS #1 LOG
delimiter $$

CREATE TRIGGER before_update_phone
BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
	IF NEW.phone_number <> OLD.phone_number THEN
		INSERT INTO phone_changes(ID_CUSTOMER,old_phone_number,new_phone_number)
		VALUES(NEW.ID_CUSTOMER,OLD.phone_number,NEW.phone_number);
	END IF;
END$$

delimiter ;


-- TRIGGER #2 UPDATE


CREATE TRIGGER class_openings 
BEFORE INSERT ON classes_attendences
FOR EACH ROW 

UPDATE classes 
SET openings=openings-1 WHERE id_classes=new.id_classes;



-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`location` 
-- -----------------------------------------------------
INSERT INTO `location`(`id_location`,`address`,`zip_code`, `city_name`) VALUES
('LX','Avenida Almirante Reis 65','1150-011','Lisbon'),
('OPO','Rua da Trindade','4000-354','Porto'),
('FAO','Rua Dona Teresa','8000-544','Faro');

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`gym`
-- -----------------------------------------------------
INSERT INTO `gym`(`id_gym`,`gym_name`,`ID_LOCATION`) VALUES
('NV01','NOVAUP LISBOA','LX'),
('NV02','NOVAUP PORTO','OPO'),
('NV03','NOVAUP FARO','FAO');

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`department`
-- -----------------------------------------------------
INSERT INTO `department`(`id_department`,`department_name`) VALUES
('TD','Trainers Department'),
('CD','Cleaning Department'),
('HD','Health Department'),
('BD','Business Department'),
('SD','Services Department');

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`employee`
-- -----------------------------------------------------
INSERT INTO `employee`(`id_employee`, `name`, `gender`, `birth_year`, `cc`, `address`, `zip_code`, `email`, `ID_GYM`, `job`, `income_per_year`, `ID_DEPARTMENT`, `first_year`) VALUES
(220, 'Susana Silva', 'F', 1987, 519053349, 'Rua Francisco Sanches 53', '1170-141', 'ssilva@gmail.com', 'NV01', 'Nutritionist', 18000, 'HD', 2019),
(262, 'Tiago Sampaio', 'M', 1988, 802029075, 'Rua Costa Cabral 290', '4200-208',  'tsampaio@gmail.com', 'NV02', 'Nutritionist', 18000, 'HD', 2014),
(264, 'Fausto Vasconcelos', 'M', 1980, 658605012, 'Rua Francisco Sanches 2', '1170-140', 'fvasconcelos@gmail.com', 'NV01', 'Trainer', 30000, 'TD', 2017),
(207, 'Patricia Alexandra', 'F', 1997, 504167636, 'Rua Costa Cabral 280', ' 4200-208 ',  'palexandra@gmail.com', 'NV02', 'Trainer', 30000, 'TD', 2020),
(270, 'Rita Fernandes', 'F', 1974, 796946570, 'Rua Francisco Sanches 120', '1170-144', 'rfernandes@gmail.com', 'NV01', 'Cleaning', 9600, 'CD', 2013),
(210, 'Pedro Barros', 'M', 1970, 665040983, 'Rua Capitão Pombeiro 3', '4250-373', 'pbarros@gmail.com', 'NV02', 'Cleaning', 9600, 'CD', 2018),
(222, 'Sara Cristina', 'F', 1975, 639505569, 'Avenida Infante de Sagres 1', '8125-156', 'scristina@gmail.com', 'NV03', 'Receptionist', 9600, 'SD', 2019),
(295, 'Sandra Azevedo', 'F', 1983, 795061525, 'Avenida Infante de Sagres 9', '8125-156', 'sazevedo@gmail.com', 'NV03', 'Cleaning', 9600, 'CD',2015),
(234, 'Pedro Martins', 'M', 1996, 523292382, 'Avenida Infante de Sagres 131', '8125-156', 'pmartins@gmail.com', 'NV03', 'Trainer', 30000, 'TD', 2016),
(244, 'Márcia Alves', 'F', 1988, 665204098, 'Rua Costa Cabral 270', '4200-208', 'tcarbery9@gmail.com', 'NV02', 'Receptionist', 12000, 'SD', 2014),
(300, 'Bruna Santos', 'F', 1983, 536330568, 'Rua Francisco Sanches 51', '1170-141', 'bsantos@gmail.com', 'NV01', 'Receptionist', 12000, 'SD', 2019),
(217, 'Liane Gomes', 'F', 1994, 722336107, 'Avenida Infante de Sagres 53', '8125-156', 'lgomes@gmail.com', 'NV03', 'Nutritionist', 30000, 'HD', 2018),
(265, 'Diana Bastos', 'F', 1976, 763013675, 'Rua Capitão Pombeiro 9', '4250-373', 'dbastos@gmail.com', 'NV02', 'CEO', 36000, 'BD', 2009);

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`classes`
-- -----------------------------------------------------
INSERT INTO `classes`(`id_classes`, `classes_name`, `ID_EMPLOYEE`, `openings`) VALUES
('Z01', 'zumba', 264, 5),
('C01', 'cycling', 264, 5),
('B01', 'box', 264, 5),
('Z02', 'zumba', 207, 5),
('C02', 'cycling', 207, 5),
('B02', 'box', 207, 5),
('Z03', 'zumba', 234, 5),
('C03', 'cycling', 234, 5),
('B03', 'box', 234, 5);

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`plans`
-- -----------------------------------------------------
INSERT INTO `plans`(`id_plan`, `plan_name`, `price`, `has_group_classes`, `has_pool`, `has_shower`, `has_nutri_evaluation`, `has_pt`) VALUES
('SC', 'Smart Cost', 15, 0, 0, 0, 0, 0),
('S', 'Standard', 35, 1, 0, 1, 0, 0),
('UP', 'UP Plan', 60, 1, 1, 1, 1, 1);

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`promotions`
-- -----------------------------------------------------
INSERT INTO `promotions`(`id_promotions`, `promo_name`, `discount`) VALUES
('SD', 'Students Discount', 0.1),
('FL', 'Fitness Lover', 0.3),
('N', 'None', 0.0);

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`customer`
-- -----------------------------------------------------
INSERT INTO `customer`(`id_customer`, `name`,`birth_year`, `gender`, `address`, `zip_code`, `phone_number`, `email`, `cc`, `first_day`, `ID_GYM`,`ID_PLAN`, `ID_PROMOTIONS`, `method_name`, `account_number`) VALUES

(1, 'Mariana Ramos', 1995, 'F', 'Avenida Almirante Reis 48', '1150-020', '919676411', 'marianaramos@oracle.com', 154872666, '2021-05-07', 'NV01', 'S', 'SD', 'Debit Card', 4248580494),
(2, 'Martim Gonçalves', 1987, 'M', 'Vila Cova da Lixa', '4615-432','966760658', 'martimgonçalvesblinklist.com', 172015956, '2020-09-21', 'NV02', 'UP', 'FL', 'Credit Card', 4174607967),
(3, 'Iris Alves', 1989, 'F', 'Rua Costa 51', '4200-236', '966628083', 'irislaves@1688.com', 113365304, '2021-10-26', 'NV02', 'SC', 'SD', 'Debit Card', 6738989062),
(4, 'Simão Jesus', 1998, 'M', 'Rua Almada Negreiros Montechoro', '8200-008', '934170461', 'simaojesus@timesonline.co.uk', 104538444, '2020-03-26', 'NV03', 'SC', 'FL', 'Credit Card', 3065617257),
(5, 'Melissa Farias', 1981, 'F', 'Avenida João Crisóstomo', '1050-125','910348451', 'melissafarias@instagram.com', 321357598, '2020-08-27', 'NV01', 'SC', 'SD', 'Debit Card', 1597149953),
(6, 'Gustavo Henrique Cavalcanti', 1985, 'M', 'Rua Cimo Vila 109', '4590-410', '936628083', 'gustavocavalcanti@istockphoto.com', 247158952, '2020-03-23', 'NV02', 'UP', 'FL', 'Credit Card', 5808250457),
(7, 'Pedro Jesus', 1972, 'M', 'Travessa Choupelo 77', '4470-106', '916162793', 'pedrojesus@ox.ac.uk', 467756141, '2020-08-13', 'NV02', 'SC', 'N', 'Credit Card', 6925273790),
(8, 'Elisa Jesus', 1972, 'F', 'Rua parque Gondarim 119', '4415-017', '916162633', 'elisajesus@netlog.com', 404269546, '2020-08-04', 'NV02', 'SC', 'N', 'Credit Card', 2693953453),
(9, 'Lara Gomes', 1986, 'F', 'Rua da Alfarrobeira', '8200-008', '914562793', 'laragomes@toplist.cz', 400244409, '2019-12-13', 'NV03', 'S', 'N', 'Credit Card', 2055479330),
(10, 'Bruno Rodrigues', 1993, 'M', 'Rua Almirante Gago Coutinho', '8200-008', '914562553', 'brunorodrigues@cornell.edu', 429496166, '2021-02-17', 'NV03', 'UP', 'N', 'Credit Card', 2303950137),
(11, 'Amanda Serpa', 1985, 'F', 'Rua Sophia de Mello Breyner', '8200-008', '964562003', 'amandaserpa@cdc.gov', 489117428, '2021-04-18', 'NV03', 'S', 'SD', 'Debit Card', 4477285006),
(12, 'Glória Dias', 1984, 'F', 'Rua Capitão Leitão Ímpares', '1950-005', '967562792', 'gloriasdias@posterous.com', 306297928, '2021-04-20', 'NV01', 'UP', 'SD', 'Debit Card', 5870807705),
(13, 'Ana Matos', 1988, 'F', 'Rua Chianca de Garcia Bairro das Salgadas', '1950-006', '967512392', 'anamatos@goodreads.com', 375908876, '2021-11-12', 'NV01', 'SC', 'SD', 'Credit Card', 3683505090),
(14, 'Bruna Araújo', 1988, 'F', 'Rua do Açúcar A', '1950-006', '917512382', 'brunaaraujo@foxnews.com', 495866365, '2021-08-07', 'NV01', 'SC', 'N', 'Credit Card', 1102497346),
(15, 'João Prazeres', 1984, 'M', 'Avenida Infante Dom Henrique Branco Totta', '1950-413', '919704690', 'joaoprazeres@hp.com', 247868523, '2020-02-10', 'NV01', 'SC', 'SD', 'Debit Card', 5824866716),
(16, 'Rosa Blanca', 1971, 'F', 'Rua Doutor António Luís Gomes', '4000-009', '919578586','rosablanca@tripadvisor.com', 181279050, '2020-06-23', 'NV02', 'SC', 'N', 'Debit Card', 5994841208),
(17, 'Pedro Ferreira', 1999, 'M', 'Jardim Arnaldo Gama', '4000-009', '967977193','pedroferreira@hubpages.com', 121393872, '2021-03-09', 'NV02', 'S', 'SD', 'Debit Card', 4794969117),
(18, 'Pedro Pires', 1963, 'M', 'Rua Actriz Palmira Bastos Bairro das Amendoeiras Pares', '1950-005', '933902457','pedropires@hubpages.com', 121393872, '2021-04-19', 'NV01', 'S', 'SD', 'Debit Card', 5456644748),
(19, 'Rute Marlene', 2001, 'F', 'Rua da Praia Maria Luisa', '8200-329', '964477193','rutemarlene@hubpages.com', 121393872, '2020-09-29', 'NV03', 'UP', 'SD', 'Credit Card', 5929888167),
(20, 'Cristina Dias', 2000, 'F', 'Travessa do Borrego', '8125-003', '967977100','cristinadias@hubpages.com', 121393872, '2021-03-09', 'NV03', 'S', 'SD', 'Credit Card', 4010840570);

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`is_student`
-- -----------------------------------------------------
INSERT INTO `is_student`( `id_customer`,`id_promotions`) VALUES
(1,'SD'),
(2,'FL'),
(3,'SD'),
(4,'FL'),
(5,'SD'),
(6,'FL'),
(7,'N'),
(8,'N'),
(9,'N'),
(10,'N'),
(11,'SD'),
(12,'SD'),
(13,'SD'),
(14,'N'),
(15,'SD'),
(16,'N'),
(17,'SD'),
(18,'SD'),
(19,'SD'),
(20,'SD');

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`payment`
-- -----------------------------------------------------
INSERT INTO `payment` (`id_payment`, `ID_CUSTOMER`,  `payment_date`, `amount`) VALUES
('0001', 1, '2021-05-07', 31.50), ('0002', 1, '2021-06-07', 31.50), ('0003', 1, '2021-07-07', 31.50), 
('0004', 1, '2021-08-07', 31.50), ('0005', 1, '2021-09-07', 31.50), ('0006', 1, '2021-10-07', 31.50),
('0007', 1, '2021-11-07', 31.50), ('0008', 1, '2021-12-07', 31.50), ('0009', 2, '2020-09-21', 42), 
('0010', 2, '2020-10-21', 42), ('0011', 2, '2020-11-21', 42), ('0012', 2, '2020-12-21', 42),
('0013', 2, '2021-01-21', 42), ('0014', 2, '2021-02-21', 42), ('0015', 2, '2021-03-21', 42), 
('0016', 2, '2021-04-21', 42), ('0017', 2, '2021-05-21', 42), ('0018', 2, '2021-06-21', 42),
('0019', 2, '2021-07-21', 42), ('0020', 2, '2021-08-21', 42),
('0021', 2, '2021-09-21', 42), ('0022', 2, '2021-10-21', 42), ('0023', 2, '2021-11-21', 42),
('0024', 2, '2021-12-21', 42), ('0025', 3, '2021-10-26', 13.5),('0026', 3, '2021-11-26', 13.5),
('0027', 3, '2021-12-26', 13.5), ('0028', 4, '2020-03-26', 10.5), ('0029', 4, '2020-04-26', 10.5),
('0030', 4, '2020-05-26', 10.5), ('0031', 4, '2020-06-26', 10.5), ('0032', 4, '2020-07-26', 10.5),
('0033', 4, '2020-08-26', 10.5), ('0034', 4, '2020-09-26', 10.5), ('0035', 4, '2020-10-26', 10.5),
('0036', 4, '2020-11-26', 10.5), ('0037', 4, '2020-12-26', 10.5), ('0038', 4, '2021-01-26', 10.5),
('0039', 4, '2021-02-26', 10.5), ('0040', 4, '2021-03-26', 10.5), ('0041', 4, '2021-04-26', 10.5),
('0042', 4, '2021-05-26', 10.5), ('0043', 4, '2021-06-26', 10.5), ('0044', 4, '2021-07-26', 10.5),
('0045', 4, '2021-08-26', 10.5), ('0049', 4, '2021-09-26', 10.5), ('0050', 4, '2021-10-26', 10.5),
('0051', 4, '2021-11-26', 10.5), ('0052', 4, '2021-12-26', 10.5), ('0053', 5, '2020-08-27', 13.5),
('0054', 5, '2020-09-27', 13.5), ('0055', 5, '2020-10-27', 13.5), ('0056', 5, '2020-11-27', 13.5),
('0057', 5, '2020-12-27', 13.5), ('0058', 5, '2021-01-27', 13.5), ('0059', 5, '2021-02-27', 13.5),
('0060', 5, '2021-03-27', 13.5), ('0061', 5, '2021-04-27', 13.5), ('0062', 5, '2021-05-27', 13.5),
('0063', 5, '2021-06-27', 13.5), ('0064', 5, '2021-07-27', 13.5), ('0065', 5, '2021-08-27', 13.5),
('0066', 5, '2021-09-27', 13.5), ('0067', 5, '2021-10-27', 13.5), ('0068', 5, '2021-11-27', 13.5),
('0069', 5, '2021-12-27', 13.5), ('0070', 6, '2020-03-23', 42), ('0071', 6, '2020-04-23', 42),
('0072', 6, '2020-05-23', 42), ('0073', 6, '2020-06-23', 42), ('0074', 6, '2020-07-23', 42),
('0075', 6, '2020-08-23', 42), ('0076', 6, '2020-09-23', 42), ('0077', 6, '2020-10-23', 42),
('0078', 6, '2020-11-23', 42), ('0079', 6, '2020-12-23', 42), ('0080', 6, '2021-01-23', 42), 
('0081', 6, '2021-02-23', 42), ('0082', 6, '2021-03-23', 42), ('0083', 6, '2021-04-23', 42),
('0085', 6, '2021-06-23', 42), ('0087', 6, '2021-08-23', 42), ('0088', 6, '2021-09-23', 42),
('0089', 6, '2021-10-23', 42), ('0090', 6, '2021-11-23', 42), ('0091', 6, '2021-12-23', 42),
('0092', 7, '2020-08-13', 15), ('0093', 7, '2020-09-13', 15), ('0094', 7, '2020-10-13', 15), 
('0095', 7, '2020-11-13', 15), ('0096', 7, '2020-12-13', 15), ('0097', 7, '2021-01-13', 15), 
('0098', 7, '2021-02-13', 15), ('0099', 7, '2021-03-13', 15), ('0100', 7, '2021-04-13', 15),
('0101', 7, '2021-05-13', 15), ('0102', 7, '2021-06-13', 15), ('0103', 7, '2021-07-13', 15),
('0104', 7, '2021-08-13', 15), ('0105', 7, '2021-09-13', 15), ('0106', 7, '2021-10-13', 15),
('0107', 7, '2021-11-13', 15), ('0108', 7, '2021-12-13', 15), ('0109', 8, '2020-08-04', 15),
('0110', 8, '2020-09-04', 15), ('0111', 8, '2020-10-04', 15), ('0112', 8, '2020-11-04', 15),
('0113', 8, '2020-12-04', 15), ('0114', 8, '2021-01-04', 15),('0115', 8, '2021-02-04', 15),
('0116', 8, '2021-03-04', 15), ('0117', 8, '2021-04-04', 15), ('0118', 8, '2021-05-04', 15),
('0119', 8, '2021-06-04', 15), ('0120', 8, '2021-07-04', 15), ('0121', 8, '2021-08-04', 15),
('0122', 8, '2021-09-04', 15), ('0123', 8, '2021-10-04', 15), ('0124', 8, '2021-11-04', 15),
('0125', 8, '2021-12-04', 15), ('0126', 9, '2019-12-13', 35), ('0127', 9, '2020-01-13', 35),
('0128', 9, '2020-02-13', 35), ('0129', 9, '2020-03-13', 35), ('0130', 9, '2020-04-13', 35), 
('0131', 9, '2020-05-13', 35), ('0132', 9, '2020-06-13', 35), ('0133', 9, '2020-07-13', 35), 
('0134', 9, '2020-08-13', 35), ('0135', 9, '2020-09-13', 35), ('0136', 9, '2020-10-13', 35), 
('0137', 9, '2020-11-13', 35), ('0138', 9, '2020-12-13', 35), ('0139', 9, '2021-01-13', 35),
('0140', 9, '2021-02-13', 35), ('0141', 9, '2021-03-13', 35), ('0142', 9, '2021-04-13', 35), 
('0143', 9, '2021-05-13', 35), ('0144', 9, '2021-06-13', 35), ('0145', 9, '2021-07-13', 35), 
('0146', 9, '2021-08-13', 35), ('0147', 9, '2021-09-13', 35), ('0148', 9, '2021-10-13', 35), 
('0149', 9, '2021-11-13', 35), ('0150', 9, '2021-12-13', 35), ('0151', 10, '2021-02-17', 60),
('0152', 10, '2021-03-17', 60), ('0153', 10, '2021-04-17', 60), ('0154', 10, '2021-05-17', 60),
('0155', 10, '2021-06-17', 60), ('0156', 10, '2021-07-17', 60), ('0157', 10, '2021-08-17', 60),
('0158', 10, '2021-09-17', 60), ('0159', 10, '2021-10-17', 60), ('0160', 10, '2021-11-17', 60),
('0161', 10, '2021-12-17', 60), ('0162', 11, '2021-04-18', 31.5), ('0163', 11, '2021-05-18', 31.5),
('0164', 11, '2021-06-18', 31.5), ('0165', 11, '2021-07-18', 31.5), ('0166', 11, '2021-08-18', 31.5),
('0167', 11, '2021-09-18', 31.5), ('0168', 11, '2021-10-18', 31.5), ('0169', 11, '2021-11-18', 31.5),
('0170', 11, '2021-12-18', 31.5), ('0171', 12, '2021-04-20', 54), ('0172', 12, '2021-05-20', 54),
('0173', 12, '2021-06-20', 54), ('0174', 12, '2021-07-20', 54), ('0175', 12, '2021-08-20', 54),
('0176', 12, '2021-09-20', 54), ('0177', 12, '2021-10-20', 54), ('0178', 12, '2021-11-20', 54),
('0179', 12, '2021-12-20', 54), ('0180', 13, '2021-11-12', 13.5), ('0181', 13, '2021-11-12', 13.5),
('0182', 14, '2021-08-07', 15), ('0183', 14, '2021-09-07', 15), ('0184', 14, '2021-10-07', 15),
('0185', 14, '2021-11-07', 15), ('0186', 14, '2021-12-07', 15), ('0187', 15, '2020-02-10', 13.5),
('0188', 15, '2020-03-10', 13.5), ('0189', 15, '2020-04-10', 13.5), ('0190', 15, '2020-05-10', 13.5),
('0191', 15, '2020-06-10', 13.5), ('0192', 15, '2020-07-10', 13.5), ('0193', 15, '2020-08-10', 13.5),
('0194', 15, '2020-09-10', 13.5), ('0195', 15, '2020-10-10', 13.5), ('0197', 15, '2020-11-10', 13.5),
('0198', 15, '2020-12-10', 13.5), ('0199', 15, '2021-01-10', 13.5), ('0200', 15, '2021-02-10', 13.5),
('0201', 15, '2021-03-10', 13.5), ('0202', 15, '2021-04-10', 13.5), ('0203', 15, '2021-05-10', 13.5),
('0204', 15, '2021-06-10', 13.5), ('0205', 15, '2021-07-10', 13.5), ('0206', 15, '2021-08-10', 13.5),
('0207', 15, '2021-09-10', 13.5), ('0208', 15, '2021-10-10', 13.5), ('0209', 15, '2021-11-10', 13.5),
('0210', 15, '2021-12-10', 13.5), ('0211', 16, '2020-06-23', 15), ('0212', 16, '2020-07-23', 15),
('0213', 16, '2020-08-23', 15), ('0214', 16, '2020-09-23', 15), ('0215', 16, '2020-10-23', 15),
('0216', 16, '2020-11-23', 15), ('0217', 16, '2020-12-23', 15), ('0218', 16, '2021-01-23', 15),
('0219', 16, '2021-02-23', 15), ('0220', 16, '2021-03-23', 15), ('0221', 16, '2021-04-23', 15),
('0222', 16, '2021-05-23', 15), ('0223', 16, '2021-06-23', 15), ('0224', 16, '2021-07-23', 15),
('0225', 16, '2021-08-23', 15), ('0226', 16, '2021-09-23', 15), ('0227', 16, '2021-10-23', 15),
('0228', 16, '2021-11-23', 15), ('0229', 16, '2021-12-23', 15), ('0230', 17, '2021-03-09', 31.5),
('0231', 17, '2021-04-09', 31.5), ('0232', 17, '2021-05-09', 31.5), ('0233', 17, '2021-06-09', 31.5),
('0234', 17, '2021-07-09', 31.5), ('0235', 17, '2021-08-09', 31.5), ('0236', 17, '2021-09-09', 31.5),
('0237', 17, '2021-10-09', 31.5), ('0238', 17, '2021-11-09', 31.5), ('0239', 17, '2021-12-09', 31.5),
('0240', 18, '2021-04-19', 31.5), ('0241', 18, '2021-05-19', 31.5), ('0242', 18, '2021-06-19', 31.5),
('0243', 18, '2021-07-19', 31.5), ('0244', 18, '2021-08-19', 31.5), ('0245', 18, '2021-09-19', 31.5),
('0246', 18, '2021-10-19', 31.5), ('0247', 18, '2021-11-19', 31.5), ('0248', 18, '2021-12-19', 31.5),
('0249', 19, '2020-09-28', 54), ('0250', 19, '2020-10-28', 54), ('0251', 19, '2020-11-28', 54),
('0252', 19, '2020-12-28', 54), ('0253', 19, '2021-01-28', 54), ('0254', 19, '2021-02-28', 54),
('0255', 19, '2021-03-28', 54), ('0256', 19, '2021-04-28', 54), ('0257', 19, '2021-05-28', 54),
('0258', 19, '2021-06-28', 54), ('0259', 19, '2021-07-28', 54), ('0260', 19, '2021-08-28', 54),
('0261', 19, '2021-09-28', 54), ('0262', 19, '2021-10-28', 54), ('0263', 19, '2021-11-28', 54),
('0264', 19, '2021-12-28', 54), ('0265', 20, '2021-02-09', 31.5), ('0266', 20, '2021-03-09', 31.5),
('0267', 20, '2021-04-09', 31.5), ('0268', 20, '2021-05-09', 31.5), ('0269', 20, '2021-06-09', 31.5),
('0270', 20, '2021-07-09', 31.5), ('0271', 20, '2021-08-09', 31.5), ('0272', 20, '2021-09-09', 31.5),
('0273', 20, '2021-10-09', 31.5), ('0274', 20, '2021-11-09', 31.5), ('0275', 20, '2021-12-09', 31.5);
-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`classes_attendences`
-- -----------------------------------------------------
INSERT INTO `classes_attendences`(`id_classes`,`id_customer`) VALUES
('Z01', 18),
('Z01', 12),
('B01', 12),
('C01', 18),
('C01',1),
('C02', 17),
('C02', 6),
('B02', 6),
('Z02', 2),
('B02', 2),
('C03', 19),
('B03', 10),
('C03', 10),
('Z03', 11),
('C03', 11),
('B03', 20);

-- -----------------------------------------------------
-- INSERT INTO Table `novaup`.`ratings`
-- -----------------------------------------------------
 INSERT INTO `ratings` (`id_ratings`,`ID_CUSTOMER`, `id_plan`, `rating`) VALUES
 ('r01', 20, 'S', 9),
 ('r02', 18, 'S', 7),
 ('r03', 17, 'S', 8),
 ('r04', 16, 'SC', 7),
 ('r05', 15, 'SC', 8),
 ('r06', 14, 'SC', 8),
 ('r07', 13, 'SC', 9),
 ('r08', 12, 'UP', 5),
 ('r09', 10, 'UP', 6),
 ('r10', 9, 'S', 8),
 ('r11', 8, 'SC', 9),
 ('r12', 7, 'SC', 7),
 ('r13', 5, 'SC', 4),
 ('r14', 4, 'SC', 8),
 ('r15', 2, 'UP', 7),
 ('r16', 1, 'S', 8);
 
 
 -- -----------------------------------------------------
-- CREATE VIEWS OF INVOICES
-- -----------------------------------------------------

-- invoice head from client number 1. if we want to chose another client we change c.id_customer on where query
#DROP VIEW IF EXISTS INVOICE_head; -- use only if view was already created
CREATE VIEW INVOICE_head AS
	SELECT 
		p.id_payment as 'Invoice Number', DATE_SUB(p.payment_date, INTERVAL 7 DAY) as 'Date of Issue',
        c.name as 'Client Name', c.address as 'Street Adress', l.city_name as 'City', 
        c.zip_code as 'Zip Code', gym.gym_name as 'Company Name', l.address as 'Company Address', 
        l.zip_code as 'Company Zip Code', CONCAT(p.amount, '€') as 'Total'
	FROM gym
    JOIN location l on gym.id_location=l.id_location
	JOIN customer c on c.id_gym=gym.id_gym 
    JOIN payment p on p.id_customer=c.id_customer
    WHERE c.id_customer=1 
    LIMIT 1;
    
    
-- invoice details from client number 1. if we want to chose another client we change c.id_customer on where query
#DROP VIEW if exists INVOICE_Details ; -- use only if view was already created
CREATE VIEW INVOICE_Details AS
 	SELECT
		pl.plan_name AS 'Description',
		CONCAT(pl.price, '€') AS 'Price',
		CONCAT(pr.promo_name, ' - ', round(pr.discount*100, 0), '%') AS 'Discount',
		CONCAT(p.amount, '€') as 'Total'
FROM  customer c
JOIN plans pl on pl.id_plan=c.id_plan
JOIN promotions pr on pr.id_promotions=c.id_promotions
JOIN payment p on p.id_customer=c.id_customer
WHERE c.id_customer = 1
GROUP BY pl.id_plan;