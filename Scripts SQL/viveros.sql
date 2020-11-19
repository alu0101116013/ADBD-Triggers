-- MySQL Script generated by MySQL Workbench
-- mié 11 nov 2020 12:42:24 WET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb_viveros
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb_viveros
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb_viveros` DEFAULT CHARACTER SET utf8 ;
USE `mydb_viveros` ;

-- -----------------------------------------------------
-- Table `mydb_viveros`.`Zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_viveros`.`Zona` (
  `Código de zona` INT NOT NULL,
  `Nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`Código de zona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_viveros`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_viveros`.`Empleado` (
  `DNI empleado` VARCHAR(30) NOT NULL,
  `Nombre` VARCHAR(60) NOT NULL,
  `Sueldo` FLOAT NOT NULL,
  `Seguridad Social` INT NOT NULL,
  `Código de zona` INT NOT NULL,
  `Fecha inicio` VARCHAR(45) NOT NULL,
  `Fecha fin` VARCHAR(45) NULL,
  PRIMARY KEY (`DNI empleado`),
  CONSTRAINT `Código de zona`
    FOREIGN KEY (`Código de zona`)
    REFERENCES `mydb_viveros`.`Zona` (`Código de zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_viveros`.`Vivero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_viveros`.`Vivero` (
  `Localización` FLOAT NOT NULL,
  `Nombre` VARCHAR(60) NOT NULL,
  `Código de zona` INT NOT NULL,
  PRIMARY KEY (`Localización`),
  CONSTRAINT `Cód de zona`
    FOREIGN KEY (`Código de zona`)
    REFERENCES `mydb_viveros`.`Zona` (`Código de zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_viveros`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_viveros`.`Producto` (
  `Código de barras` INT NOT NULL,
  `Nombre` VARCHAR(60) NOT NULL,
  `Tipo` VARCHAR(60) NOT NULL,
  `Precio` FLOAT NOT NULL,
  `Stock` INT NULL,
  `Código de zona` INT NOT NULL,
  PRIMARY KEY (`Código de barras`),
  CONSTRAINT `Código zona`
    FOREIGN KEY (`Código de zona`)
    REFERENCES `mydb_viveros`.`Zona` (`Código de zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_viveros`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_viveros`.`Cliente` (
  `DNI cliente` VARCHAR(30) NOT NULL,
  `Nombre` VARCHAR(60) NOT NULL,
  `Bonificación` FLOAT NULL,
  `Gasto mensual` FLOAT NULL,
  `Código de pedido` INT NOT NULL,
  PRIMARY KEY (`DNI cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb_viveros`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb_viveros`.`Pedido` (
  `Código de pedido` INT NOT NULL,
  `Fecha` VARCHAR(45) NULL,
  `Importe` FLOAT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Código de barras` INT NOT NULL,
  `DNI empleado` VARCHAR(30) NOT NULL,
  `DNI cliente` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Código de pedido`),
  CONSTRAINT `Código de barras`
    FOREIGN KEY (`Código de barras`)
    REFERENCES `mydb_viveros`.`Producto` (`Código de barras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DNI empleado`
    FOREIGN KEY (`DNI empleado`)
    REFERENCES `mydb_viveros`.`Empleado` (`DNI empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DNI cliente`
    FOREIGN KEY (`DNI cliente`)
    REFERENCES `mydb_viveros`.`Cliente` (`DNI cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Procedure crear_email
-- -----------------------------------------------------

DELIMITER // 
USE `mydb_viveros`;
CREATE PROCEDURE `crear_email` (IN DNI varchar(60), IN dominio VARCHAR(60), OUT email varchar(60))
BEGIN
    SET email = CONCAT(DNI, '@', dominio);
END
//
DELIMITER ;


DELIMITER //
USE `mydb_viveros`;
CREATE DEFINER = `kabir`@`ull.es` TRIGGER `mydb_viveros`.`trigger_crear_email_before_insert` BEFORE INSERT ON `Cliente` FOR EACH ROW
BEGIN
	IF NEW.email IS NULL THEN
		CALL crear_email(NEW.DNI, 'ull.es', @email);
    	SET NEW.email = @email;
    END IF;
END
//
DELIMITER ;


-- -----------------------------------------------------
-- Stock
-- -----------------------------------------------------

DELIMITER // 
USE `mydb_viveros`;
CREATE DEFINER=`kabir`@`ull.es` TRIGGER `mydb_viveros`.`actualiza_stock` BEFORE INSERT ON `Pedido` FOR EACH ROW
BEGIN
	SET @nuevoStock = (SELECT Stock FROM Producto WHERE codigo = NEW.Código de barras);
    SET @nuevoStock = (@nuevoStock - NEW.Stock);
    IF @nuevoStock < 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Imposible realizar pedido. No hay stock del producto';
	ELSE 
		UPDATE Producto SET Stock = @nuevoStock WHERE codigo = NEW.Código de barras;
	END IF;
END
//
DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;