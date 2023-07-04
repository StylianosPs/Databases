-- MySQL Script generated by MySQL Workbench
-- Sat Apr 25 21:19:19 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ergazomenos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ergazomenos` (
  `kwdikos_ER` INT NOT NULL,
  `onomateponimo` VARCHAR(45) NOT NULL,
  `rolos` ENUM('diefthintis', 'chef', 'mageiras', 'voithos mageira', 'dimosies sxeseis', 'servitoros', 'tameias', 'metaforeas', 'logistis') NOT NULL,
  `misthos` FLOAT NOT NULL,
  `imerominia_pros` DATE NULL,
  `diefthinsi` VARCHAR(45) NULL,
  `poli` VARCHAR(45) NULL,
  `tax_kwdikas` INT NULL,
  `tilefwno` INT UNSIGNED NULL,
  `email` VARCHAR(45) NULL,
  `estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`kwdikos_ER`, `estiatorio_kwdikos_E`),
  INDEX `fk_ergazomenos_estiatorio1_idx` (`estiatorio_kwdikos_E` ASC) VISIBLE,
  CONSTRAINT `fk_ergazomenos_estiatorio1`
    FOREIGN KEY (`estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`estiatorio` (`kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`estiatorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estiatorio` (
  `kwdikos_E` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `diefthinsi` VARCHAR(45) NOT NULL,
  `poli` VARCHAR(45) NOT NULL,
  `tax_kwdikas` INT UNSIGNED NOT NULL,
  `tilefono` INT UNSIGNED NOT NULL,
  `wres_leitourgias` TIME NOT NULL,
  `ergazomenos_diefthintis` INT NOT NULL,
  PRIMARY KEY (`kwdikos_E`),
  INDEX `fk_estiatorio_ergazomenos1_idx` (`ergazomenos_diefthintis` ASC) VISIBLE,
  CONSTRAINT `fk_estiatorio_ergazomenos1`
    FOREIGN KEY (`ergazomenos_diefthintis`)
    REFERENCES `mydb`.`ergazomenos` (`kwdikos_ER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`miniaio_programma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`miniaio_programma` (
  `vardies` DATETIME(31) NULL,
  `tropos_plirwmis` VARCHAR(45) NULL,
  `misthos` FLOAT UNSIGNED NULL,
  `ergazomenos_kwdikos_ER` INT NOT NULL,
  `ergazomenos_estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`ergazomenos_kwdikos_ER`, `ergazomenos_estiatorio_kwdikos_E`),
  CONSTRAINT `fk_miniaio_programma_ergazomenos1`
    FOREIGN KEY (`ergazomenos_kwdikos_ER` , `ergazomenos_estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`ergazomenos` (`kwdikos_ER` , `estiatorio_kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`promitheftis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`promitheftis` (
  `kwdikos_PR` INT UNSIGNED NOT NULL,
  `epwnimo` VARCHAR(45) NOT NULL,
  `diefthinsi` VARCHAR(45) NOT NULL,
  `tilefwno` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`kwdikos_PR`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prwtes_iles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prwtes_iles` (
  `kwdikos_PR_IL` INT UNSIGNED NOT NULL,
  `onoma` VARCHAR(45) NOT NULL,
  `perigrafi` VARCHAR(45) NOT NULL,
  `varos` VARCHAR(45) NOT NULL,
  `imerominia` DATE NOT NULL,
  `promitheftis_kwdikos_PR` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`kwdikos_PR_IL`, `promitheftis_kwdikos_PR`),
  INDEX `fk_prwtes_iles_promitheftis1_idx` (`promitheftis_kwdikos_PR` ASC) VISIBLE,
  CONSTRAINT `fk_prwtes_iles_promitheftis1`
    FOREIGN KEY (`promitheftis_kwdikos_PR`)
    REFERENCES `mydb`.`promitheftis` (`kwdikos_PR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`plirwmes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`plirwmes` (
  `kwdikos_PL` INT UNSIGNED NOT NULL,
  `imerominia_plir` DATE NULL,
  `tropos_pl` VARCHAR(45) NULL,
  `poso` FLOAT NULL,
  `estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  `promitheftis_kwdikos_PR` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`kwdikos_PL`, `estiatorio_kwdikos_E`, `promitheftis_kwdikos_PR`),
  INDEX `fk_plirwmes_estiatorio1_idx` (`estiatorio_kwdikos_E` ASC) VISIBLE,
  INDEX `fk_plirwmes_promitheftis1_idx` (`promitheftis_kwdikos_PR` ASC) VISIBLE,
  CONSTRAINT `fk_plirwmes_estiatorio1`
    FOREIGN KEY (`estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`estiatorio` (`kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_plirwmes_promitheftis1`
    FOREIGN KEY (`promitheftis_kwdikos_PR`)
    REFERENCES `mydb`.`promitheftis` (`kwdikos_PR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paragelies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paragelies` (
  `kwdiko_PA` INT NOT NULL,
  `imerominia_parag` DATE NULL,
  `imerominia_paral` DATE NULL,
  `estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  `onoma_ergazomenou` VARCHAR(45) NULL,
  PRIMARY KEY (`kwdiko_PA`, `estiatorio_kwdikos_E`),
  INDEX `fk_paragelies_estiatorio1_idx` (`estiatorio_kwdikos_E` ASC) VISIBLE,
  CONSTRAINT `fk_paragelies_estiatorio1`
    FOREIGN KEY (`estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`estiatorio` (`kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`piato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`piato` (
  `onoma` VARCHAR(45) NOT NULL,
  `timi` FLOAT NULL,
  `thermides` FLOAT NULL,
  `varos` FLOAT NULL,
  `allergies` VARCHAR(45) NULL,
  PRIMARY KEY (`onoma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`piato_has_prwtes_iles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`piato_has_prwtes_iles` (
  `piato_onoma` VARCHAR(45) NOT NULL,
  `prwtes_iles_kwdikos_PR_IL` INT UNSIGNED NOT NULL,
  `posotita` VARCHAR(45) NULL,
  PRIMARY KEY (`piato_onoma`, `prwtes_iles_kwdikos_PR_IL`),
  INDEX `fk_piato_has_prwtes_iles_prwtes_iles1_idx` (`prwtes_iles_kwdikos_PR_IL` ASC) VISIBLE,
  INDEX `fk_piato_has_prwtes_iles_piato1_idx` (`piato_onoma` ASC) VISIBLE,
  CONSTRAINT `fk_piato_has_prwtes_iles_piato1`
    FOREIGN KEY (`piato_onoma`)
    REFERENCES `mydb`.`piato` (`onoma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_piato_has_prwtes_iles_prwtes_iles1`
    FOREIGN KEY (`prwtes_iles_kwdikos_PR_IL`)
    REFERENCES `mydb`.`prwtes_iles` (`kwdikos_PR_IL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pelates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pelates` (
  `kwdikos_PEL` INT UNSIGNED NOT NULL,
  `onoma` VARCHAR(45) NULL,
  `epitheto` VARCHAR(45) NULL,
  `periorismoi` VARCHAR(45) NULL,
  `arithmos_thesewn` INT NULL,
  `ergazomenos_kwdikos_ER` INT NOT NULL,
  `ergazomenos_estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`kwdikos_PEL`),
  INDEX `fk_pelates_ergazomenos1_idx` (`ergazomenos_kwdikos_ER` ASC, `ergazomenos_estiatorio_kwdikos_E` ASC) VISIBLE,
  CONSTRAINT `fk_pelates_ergazomenos1`
    FOREIGN KEY (`ergazomenos_kwdikos_ER` , `ergazomenos_estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`ergazomenos` (`kwdikos_ER` , `estiatorio_kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paragelies_pelatwn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paragelies_pelatwn` (
  `imerominia_parag` DATETIME NOT NULL,
  `pelates_kwdikos_PEL` INT UNSIGNED NOT NULL,
  `estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`imerominia_parag`, `pelates_kwdikos_PEL`),
  INDEX `fk_paragelies_pelatwn_pelates1_idx` (`pelates_kwdikos_PEL` ASC) VISIBLE,
  INDEX `fk_paragelies_pelatwn_estiatorio1_idx` (`estiatorio_kwdikos_E` ASC) VISIBLE,
  CONSTRAINT `fk_paragelies_pelatwn_pelates1`
    FOREIGN KEY (`pelates_kwdikos_PEL`)
    REFERENCES `mydb`.`pelates` (`kwdikos_PEL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paragelies_pelatwn_estiatorio1`
    FOREIGN KEY (`estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`estiatorio` (`kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`plirwmi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`plirwmi` (
  `tropos` VARCHAR(45) NOT NULL,
  `poso` FLOAT NULL,
  `pelates_kwdikos_PEL` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`pelates_kwdikos_PEL`),
  INDEX `fk_plirwmi_pelates1_idx` (`pelates_kwdikos_PEL` ASC) VISIBLE,
  CONSTRAINT `fk_plirwmi_pelates1`
    FOREIGN KEY (`pelates_kwdikos_PEL`)
    REFERENCES `mydb`.`pelates` (`kwdikos_PEL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`axiologisi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`axiologisi` (
  `kwdikos_axiol` INT UNSIGNED NOT NULL,
  `protinomeno_apo` VARCHAR(45) NOT NULL,
  `imeronimia_axiol` DATE NULL,
  `sxolia` VARCHAR(45) NULL,
  `vathmos` INT NULL,
  `kritiki` ENUM('thetiki', 'arnitiki') NULL,
  `pelates_kwdikos_PEL` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`kwdikos_axiol`, `pelates_kwdikos_PEL`),
  INDEX `fk_axiologisi_pelates1_idx` (`pelates_kwdikos_PEL` ASC) VISIBLE,
  CONSTRAINT `fk_axiologisi_pelates1`
    FOREIGN KEY (`pelates_kwdikos_PEL`)
    REFERENCES `mydb`.`pelates` (`kwdikos_PEL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`elexos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`elexos` (
  `kwdikos_EL` INT UNSIGNED NOT NULL,
  `imerominia_el` DATE NULL,
  `onomateponimo` VARCHAR(45) NULL,
  `vathmos` INT NULL,
  `ekthesi_pepragmenwn` VARCHAR(45) NULL,
  `estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`kwdikos_EL`),
  INDEX `fk_elexos_estiatorio1_idx` (`estiatorio_kwdikos_E` ASC) VISIBLE,
  CONSTRAINT `fk_elexos_estiatorio1`
    FOREIGN KEY (`estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`estiatorio` (`kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paragelies_has_prwtes_iles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paragelies_has_prwtes_iles` (
  `paragelies_kwdiko_PA` INT NOT NULL,
  `paragelies_estiatorio_kwdikos_E` INT UNSIGNED NOT NULL,
  `prwtes_iles_kwdikos_PR_IL` INT UNSIGNED NOT NULL,
  `prwtes_iles_promitheftis_kwdikos_PR` INT UNSIGNED NOT NULL,
  `posotita` INT NULL,
  PRIMARY KEY (`paragelies_kwdiko_PA`, `paragelies_estiatorio_kwdikos_E`, `prwtes_iles_kwdikos_PR_IL`, `prwtes_iles_promitheftis_kwdikos_PR`),
  INDEX `fk_paragelies_has_prwtes_iles_prwtes_iles1_idx` (`prwtes_iles_kwdikos_PR_IL` ASC, `prwtes_iles_promitheftis_kwdikos_PR` ASC) VISIBLE,
  INDEX `fk_paragelies_has_prwtes_iles_paragelies1_idx` (`paragelies_kwdiko_PA` ASC, `paragelies_estiatorio_kwdikos_E` ASC) VISIBLE,
  CONSTRAINT `fk_paragelies_has_prwtes_iles_paragelies1`
    FOREIGN KEY (`paragelies_kwdiko_PA` , `paragelies_estiatorio_kwdikos_E`)
    REFERENCES `mydb`.`paragelies` (`kwdiko_PA` , `estiatorio_kwdikos_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paragelies_has_prwtes_iles_prwtes_iles1`
    FOREIGN KEY (`prwtes_iles_kwdikos_PR_IL` , `prwtes_iles_promitheftis_kwdikos_PR`)
    REFERENCES `mydb`.`prwtes_iles` (`kwdikos_PR_IL` , `promitheftis_kwdikos_PR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paragelies_pelatwn_has_piato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paragelies_pelatwn_has_piato` (
  `paragelies_pelatwn_imerominia_parag` DATETIME NOT NULL,
  `paragelies_pelatwn_pelates_kwdikos_PEL` INT UNSIGNED NOT NULL,
  `piato_onoma` VARCHAR(45) NOT NULL,
  `posostita` INT NULL,
  PRIMARY KEY (`paragelies_pelatwn_imerominia_parag`, `paragelies_pelatwn_pelates_kwdikos_PEL`, `piato_onoma`),
  INDEX `fk_paragelies_pelatwn_has_piato_piato1_idx` (`piato_onoma` ASC) VISIBLE,
  INDEX `fk_paragelies_pelatwn_has_piato_paragelies_pelatwn1_idx` (`paragelies_pelatwn_imerominia_parag` ASC, `paragelies_pelatwn_pelates_kwdikos_PEL` ASC) VISIBLE,
  CONSTRAINT `fk_paragelies_pelatwn_has_piato_paragelies_pelatwn1`
    FOREIGN KEY (`paragelies_pelatwn_imerominia_parag` , `paragelies_pelatwn_pelates_kwdikos_PEL`)
    REFERENCES `mydb`.`paragelies_pelatwn` (`imerominia_parag` , `pelates_kwdikos_PEL`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paragelies_pelatwn_has_piato_piato1`
    FOREIGN KEY (`piato_onoma`)
    REFERENCES `mydb`.`piato` (`onoma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
