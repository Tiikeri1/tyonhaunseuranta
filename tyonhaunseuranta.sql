-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tyonhaunseuranta
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tyonhaunseuranta` ;

-- -----------------------------------------------------
-- Schema tyonhaunseuranta
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tyonhaunseuranta` DEFAULT CHARACTER SET utf8mb3 ;
USE `tyonhaunseuranta` ;

-- -----------------------------------------------------
-- Table `tyonhaunseuranta`.`yritys`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tyonhaunseuranta`.`yritys` ;

CREATE TABLE IF NOT EXISTS `tyonhaunseuranta`.`yritys` (
  `yritysID` INT NOT NULL AUTO_INCREMENT,
  `nimi` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`yritysID`),
  UNIQUE INDEX `nimi` (`nimi` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tyonhaunseuranta`.`tyoilmoitus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tyonhaunseuranta`.`tyoilmoitus` ;

CREATE TABLE IF NOT EXISTS `tyonhaunseuranta`.`tyoilmoitus` (
  `tyoilmoitusID` INT NOT NULL AUTO_INCREMENT,
  `otsikko` VARCHAR(45) NOT NULL,
  `kuvaus` TEXT NOT NULL,
  `yritysID` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tyoilmoitusID`),
  INDEX `fk_tyoilmoitus_yritys_idx` (`yritysID` ASC) VISIBLE,
  CONSTRAINT `fk_tyoilmoitus_yritys`
    FOREIGN KEY (`yritysID`)
    REFERENCES `tyonhaunseuranta`.`yritys` (`yritysID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tyonhaunseuranta`.`tyonhakija`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tyonhaunseuranta`.`tyonhakija` ;

CREATE TABLE IF NOT EXISTS `tyonhaunseuranta`.`tyonhakija` (
  `tyonhakijaID` INT NOT NULL AUTO_INCREMENT,
  `nimi` VARCHAR(45) NOT NULL,
  `syntymaaika` DATE NOT NULL,
  `osoite` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tyonhakijaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tyonhaunseuranta`.`tyohakemus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tyonhaunseuranta`.`tyohakemus` ;

CREATE TABLE IF NOT EXISTS `tyonhaunseuranta`.`tyohakemus` (
  `tyohakemusID` INT NOT NULL AUTO_INCREMENT,
  `hakupvm` DATE NOT NULL,
  `tila` ENUM('Avoin', 'Haastattelu', 'Hylätty', 'Hyväksytty') NOT NULL,
  `tyonhakijaID` INT NOT NULL,
  `tyoilmoitusID` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tyohakemusID`),
  INDEX `fk_tyohakemus_tyonhakija1_idx` (`tyonhakijaID` ASC) VISIBLE,
  INDEX `fk_tyohakemus_tyoilmoitus1_idx` (`tyoilmoitusID` ASC) VISIBLE,
  CONSTRAINT `fk_tyohakemus_tyoilmoitus1`
    FOREIGN KEY (`tyoilmoitusID`)
    REFERENCES `tyonhaunseuranta`.`tyoilmoitus` (`tyoilmoitusID`),
  CONSTRAINT `fk_tyohakemus_tyonhakija1`
    FOREIGN KEY (`tyonhakijaID`)
    REFERENCES `tyonhaunseuranta`.`tyonhakija` (`tyonhakijaID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `tyonhaunseuranta`.`haastattelu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tyonhaunseuranta`.`haastattelu` ;

CREATE TABLE IF NOT EXISTS `tyonhaunseuranta`.`haastattelu` (
  `haastatteluID` INT NOT NULL AUTO_INCREMENT,
  `paivamaara` DATE NOT NULL,
  `tyyppi` ENUM('Puhelin', 'Teams', 'Yksilöhaastattelu', 'Ryhmähaastattelu') NULL DEFAULT NULL,
  `tila` ENUM('Tulossa', 'Pidetty', 'Peruttu', 'Hylätty', 'Hyväksytty') NOT NULL,
  `tyohakemusID` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`haastatteluID`),
  INDEX `fk_haastattelu_tyohakemus1_idx` (`tyohakemusID` ASC) VISIBLE,
  CONSTRAINT `fk_haastattelu_tyohakemus1`
    FOREIGN KEY (`tyohakemusID`)
    REFERENCES `tyonhaunseuranta`.`tyohakemus` (`tyohakemusID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
