-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema appdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema appdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `appdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `appdb` ;

-- -----------------------------------------------------
-- Table `appdb`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Persona` (
  `idPersona` INT NOT NULL COMMENT '',
  `nombre` VARCHAR(45) NOT NULL COMMENT '',
  `apellido` VARCHAR(45) NOT NULL COMMENT '',
  `ruc_ci` VARCHAR(15) NOT NULL COMMENT '',
  PRIMARY KEY (`idPersona`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `appdb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Usuario` (
  `idUsuario` INT NOT NULL COMMENT '',
  `idPersona` INT NOT NULL COMMENT '',
  `clave` VARCHAR(10) NOT NULL COMMENT '',
  PRIMARY KEY (`idUsuario`)  COMMENT '',
  INDEX `fk_Usuario_Persona1_idx` (`idPersona` ASC)  COMMENT '',
  CONSTRAINT `fk_Usuario_Persona1`
    FOREIGN KEY (`idPersona`)
    REFERENCES `appdb`.`Persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `appdb`.`Negocio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Negocio` (
  `idNegocio` INT NOT NULL COMMENT '',
  `idPersona` INT NOT NULL COMMENT '',
  `nombre_neg` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`idNegocio`)  COMMENT '',
  INDEX `fk_Negocio_Persona_idx` (`idPersona` ASC)  COMMENT '',
  CONSTRAINT `fk_Negocio_Persona`
    FOREIGN KEY (`idPersona`)
    REFERENCES `appdb`.`Persona` (`idPersona`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `appdb`.`Posicion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Posicion` (
  `idPosicion` INT NOT NULL COMMENT '',
  `idNegocio` INT NOT NULL COMMENT '',
  `latitud` VARCHAR(15) NOT NULL COMMENT '',
  `longitud` VARCHAR(15) NOT NULL COMMENT '',
  PRIMARY KEY (`idPosicion`)  COMMENT '',
  INDEX `fk_Posicion_Negocio1_idx` (`idNegocio` ASC)  COMMENT '',
  CONSTRAINT `fk_Posicion_Negocio1`
    FOREIGN KEY (`idNegocio`)
    REFERENCES `appdb`.`Negocio` (`idNegocio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = ucs2
COLLATE = ucs2_general_ci;


-- -----------------------------------------------------
-- Table `appdb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Item` (
  `idItem` INT NOT NULL COMMENT '',
  `nombre` VARCHAR(45) NOT NULL COMMENT '',
  `descripcion` VARCHAR(150) NOT NULL COMMENT '',
  PRIMARY KEY (`idItem`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `appdb`.`Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Inventario` (
  `idInventario` INT NOT NULL COMMENT '',
  `idUsuario` INT NOT NULL COMMENT '',
  `idItem` INT NOT NULL COMMENT '',
  `fecha` DATE NULL COMMENT '',
  PRIMARY KEY (`idInventario`)  COMMENT '',
  INDEX `fk_Inventario_Usuario1_idx` (`idUsuario` ASC)  COMMENT '',
  INDEX `fk_Inventario_Item1_idx` (`idItem` ASC)  COMMENT '',
  CONSTRAINT `fk_Inventario_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `appdb`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Inventario_Item1`
    FOREIGN KEY (`idItem`)
    REFERENCES `appdb`.`Item` (`idItem`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `appdb`.`Tipo_Promo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Tipo_Promo` (
  `idTipo_Promo` INT NOT NULL COMMENT '',
  `descrip_promo` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`idTipo_Promo`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `appdb`.`Promo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appdb`.`Promo` (
  `idPromo` INT NOT NULL COMMENT '',
  `idItem` INT NOT NULL COMMENT '',
  `precio` DOUBLE NOT NULL COMMENT '',
  `idTipo_Promo` INT NOT NULL COMMENT '',
  `idUsuario` INT NOT NULL COMMENT '',
  PRIMARY KEY (`idPromo`)  COMMENT '',
  INDEX `fk_Promo_Item1_idx` (`idItem` ASC)  COMMENT '',
  INDEX `fk_Promo_Tipo_Promo1_idx` (`idTipo_Promo` ASC)  COMMENT '',
  INDEX `fk_Promo_Usuario1_idx` (`idUsuario` ASC)  COMMENT '',
  CONSTRAINT `fk_Promo_Item1`
    FOREIGN KEY (`idItem`)
    REFERENCES `appdb`.`Item` (`idItem`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Promo_Tipo_Promo1`
    FOREIGN KEY (`idTipo_Promo`)
    REFERENCES `appdb`.`Tipo_Promo` (`idTipo_Promo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Promo_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `appdb`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
