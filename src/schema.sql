-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema huskywatch
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema huskywatch
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `huskywatch` DEFAULT CHARACTER SET utf8 ;
USE `huskywatch` ;

-- -----------------------------------------------------
-- Table `huskywatch`.`Area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `huskywatch`.`Area` (
  `id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `huskywatch`.`CountActual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `huskywatch`.`CountActual` (
  `area_id` INT NOT NULL,
  `count` INT NOT NULL,
  `time` DATETIME NOT NULL,
  INDEX `area_fk_key_idx` (`area_id` ASC),
  CONSTRAINT `area_fk_key`
    FOREIGN KEY (`area_id`)
    REFERENCES `huskywatch`.`Area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `huskywatch`.`CountPrediction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `huskywatch`.`CountPrediction` (
  `area_id` INT NOT NULL,
  `count` INT NOT NULL,
  `time` DATETIME NOT NULL,
  INDEX `area_fk_key_idx` (`area_id` ASC),
  CONSTRAINT `area_fk_key0`
    FOREIGN KEY (`area_id`)
    REFERENCES `huskywatch`.`Area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `huskywatch`.`Weather`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `huskywatch`.`Weather` (
  `time` DATETIME NOT NULL,
  `temperature` INT NOT NULL,
  `precipitation` TINYINT NOT NULL,
  PRIMARY KEY (`time`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `huskywatch`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `huskywatch`.`Schedule` (
  `area_id` INT NOT NULL,
  `start_time` TIME NULL,
  `end_time` TIME NULL,
  INDEX `area_id_idx` (`area_id` ASC),
  CONSTRAINT `area_id`
    FOREIGN KEY (`area_id`)
    REFERENCES `huskywatch`.`Area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
