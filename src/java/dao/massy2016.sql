DELIMITER $$
DROP SCHEMA IF EXISTS agriote_massy2016 $$
CREATE SCHEMA IF NOT EXISTS agriote_massy2016 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci $$
USE agriote_massy2016 $$

-- Lever temporairement les contraintes d'intégrité
SET FOREIGN_KEY_CHECKS=0 $$
DROP TABLE IF EXISTS membre $$
DROP TABLE IF EXISTS matiere $$
DROP TABLE IF EXISTS formateur $$
DROP TABLE IF EXISTS formation $$
DROP TABLE IF EXISTS session $$
DROP TABLE IF EXISTS projet_multi_equipe $$
DROP TABLE IF EXISTS bulletin $$
DROP TABLE IF EXISTS evaluation $$
DROP TABLE IF EXISTS etat_candidature $$
DROP TABLE IF EXISTS candidature $$
DROP TABLE IF EXISTS ligne_de_bulletin $$
DROP TABLE IF EXISTS note $$
DROP TABLE IF EXISTS equipe $$
DROP TABLE IF EXISTS seance $$
DROP TABLE IF EXISTS matiere_has_formation $$
DROP TABLE IF EXISTS subsiste $$



-- -----------------------------------------------------
-- Table `agriote_massy2016`.`membre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`membre` (
  `id_membre` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `code_postal` INT NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `telephone` INT NOT NULL,
  `photo` VARCHAR(45) NULL,
  `admin` TINYINT(1) NULL,
  PRIMARY KEY (`id_membre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`matiere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`matiere` (
  `id_matiere` INT NOT NULL AUTO_INCREMENT,
  `intitule_matiere` VARCHAR(45) NOT NULL,
  `nb_jour` INT NULL,
  `description_matiere` VARCHAR(100) NULL,
  PRIMARY KEY (`id_matiere`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`formateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`formateur` (
  `id_formateur` INT NOT NULL AUTO_INCREMENT,
  `id_matiere` INT NOT NULL,
  `id_membre` INT NOT NULL,
  `web_site` VARCHAR(45) NULL,
  PRIMARY KEY (`id_formateur`),
  INDEX `fk_formateur_membre1_idx` (`id_membre` ASC),
  INDEX `fk_formateur_matiere1_idx` (`id_matiere` ASC),
  CONSTRAINT `fk_formateur_membre1`
    FOREIGN KEY (`id_membre`)
    REFERENCES `agriote_massy2016`.`membre` (`id_membre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_formateur_matiere1`
    FOREIGN KEY (`id_matiere`)
    REFERENCES `agriote_massy2016`.`matiere` (`id_matiere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`formation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`formation` (
  `id_formation` INT NOT NULL AUTO_INCREMENT,
  `intitule_formation` VARCHAR(45) NOT NULL,
  `description_formation` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_formation`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`session` (
  `id_session` INT NOT NULL AUTO_INCREMENT,
  `id_formation` INT NOT NULL,
  `date_debut` DATE NOT NULL,
  `date_fin` DATE NOT NULL,
  `nbr_places` INT NOT NULL,
  PRIMARY KEY (`id_session`),
  INDEX `fk_session_formation1_idx` (`id_formation` ASC),
  CONSTRAINT `fk_session_formation1`
    FOREIGN KEY (`id_formation`)
    REFERENCES `agriote_massy2016`.`formation` (`id_formation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`projet_multi_equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`projet_multi_equipe` (
  `id_projet_multi_equipe` INT NOT NULL AUTO_INCREMENT,
  `id_formateur` INT NOT NULL,
  `id_session` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `date_creation` DATE NOT NULL,
  `date_fin` DATE NOT NULL,
  PRIMARY KEY (`id_projet_multi_equipe`),
  INDEX `fk_projet_multi_equipe_formateur1_idx` (`id_formateur` ASC),
  INDEX `fk_projet_multi_equipe_session1_idx` (`id_session` ASC),
  CONSTRAINT `fk_projet_multi_equipe_formateur1`
    FOREIGN KEY (`id_formateur`)
    REFERENCES `agriote_massy2016`.`formateur` (`id_formateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projet_multi_equipe_session1`
    FOREIGN KEY (`id_session`)
    REFERENCES `agriote_massy2016`.`session` (`id_session`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`bulletin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`bulletin` (
  `id_bulletin` INT NOT NULL AUTO_INCREMENT,
  `id_membre` INT NOT NULL,
  `id_session` INT NOT NULL,
  `id_formation` INT NOT NULL,
  `commentaire_general` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id_bulletin`),
  INDEX `fk_bulletin_membre1_idx` (`id_membre` ASC),
  INDEX `fk_bulletin_session1_idx` (`id_session` ASC),
  INDEX `fk_bulletin_formation1_idx` (`id_formation` ASC),
  CONSTRAINT `fk_bulletin_membre1`
    FOREIGN KEY (`id_membre`)
    REFERENCES `agriote_massy2016`.`membre` (`id_membre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bulletin_session1`
    FOREIGN KEY (`id_session`)
    REFERENCES `agriote_massy2016`.`session` (`id_session`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bulletin_formation1`
    FOREIGN KEY (`id_formation`)
    REFERENCES `agriote_massy2016`.`formation` (`id_formation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`evaluation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`evaluation` (
  `id_evaluation` INT NOT NULL AUTO_INCREMENT,
  `id_session` INT NOT NULL,
  `id_formateur` INT NOT NULL,
  `id_matiere` INT NOT NULL,
  `date_eval` DATETIME NOT NULL,
  `commentaire` VARCHAR(200) NULL,
  PRIMARY KEY (`id_evaluation`),
  INDEX `fk_evaluation_session1_idx` (`id_session` ASC),
  INDEX `fk_evaluation_formateur1_idx` (`id_formateur` ASC),
  INDEX `fk_evaluation_matiere1_idx` (`id_matiere` ASC),
  CONSTRAINT `fk_evaluation_session1`
    FOREIGN KEY (`id_session`)
    REFERENCES `agriote_massy2016`.`session` (`id_session`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluation_formateur1`
    FOREIGN KEY (`id_formateur`)
    REFERENCES `agriote_massy2016`.`formateur` (`id_formateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluation_matiere1`
    FOREIGN KEY (`id_matiere`)
    REFERENCES `agriote_massy2016`.`matiere` (`id_matiere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`etat_candidature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`etat_candidature` (
  `id_etat_candidature` INT NOT NULL AUTO_INCREMENT,
  `intitule` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_etat_candidature`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`candidature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`candidature` (
  `id_membre` INT NOT NULL AUTO_INCREMENT,
  `id_session` INT NOT NULL,
  `id_etat_candidature` INT NOT NULL,
  PRIMARY KEY (`id_membre`, `id_session`),
  INDEX `fk_membre_has_session_session1_idx` (`id_session` ASC),
  INDEX `fk_membre_has_session_membre_idx` (`id_membre` ASC),
  INDEX `fk_membre_has_session_etat_candidature1_idx` (`id_etat_candidature` ASC),
  CONSTRAINT `fk_membre_has_session_membre`
    FOREIGN KEY (`id_membre`)
    REFERENCES `agriote_massy2016`.`membre` (`id_membre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_membre_has_session_session1`
    FOREIGN KEY (`id_session`)
    REFERENCES `agriote_massy2016`.`session` (`id_session`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_membre_has_session_etat_candidature1`
    FOREIGN KEY (`id_etat_candidature`)
    REFERENCES `agriote_massy2016`.`etat_candidature` (`id_etat_candidature`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`ligne_de_bulletin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`ligne_de_bulletin` (
  `id_ligne_de_bulletin` INT NOT NULL AUTO_INCREMENT,
  `id_bulletin` INT NOT NULL,
  `id_matiere` INT NOT NULL,
  `commentaire` VARCHAR(100) NULL,
  PRIMARY KEY (`id_ligne_de_bulletin`),
  INDEX `fk_ligne_de_bulletin_bulletin1_idx` (`id_bulletin` ASC),
  INDEX `fk_ligne_de_bulletin_matiere1_idx` (`id_matiere` ASC),
  CONSTRAINT `fk_ligne_de_bulletin_bulletin1`
    FOREIGN KEY (`id_bulletin`)
    REFERENCES `agriote_massy2016`.`bulletin` (`id_bulletin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ligne_de_bulletin_matiere1`
    FOREIGN KEY (`id_matiere`)
    REFERENCES `agriote_massy2016`.`matiere` (`id_matiere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`note` (
  `id_note` INT NOT NULL AUTO_INCREMENT,
  `id_evaluation` INT NOT NULL,
  `id_membre` INT NOT NULL,
  `note` INT NULL,
  PRIMARY KEY (`id_note`),
  INDEX `fk_note_evaluation1_idx` (`id_evaluation` ASC),
  INDEX `fk_note_membre1_idx` (`id_membre` ASC),
  CONSTRAINT `fk_note_evaluation1`
    FOREIGN KEY (`id_evaluation`)
    REFERENCES `agriote_massy2016`.`evaluation` (`id_evaluation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_note_membre1`
    FOREIGN KEY (`id_membre`)
    REFERENCES `agriote_massy2016`.`membre` (`id_membre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`equipe` (
  `id_equipe` INT NOT NULL AUTO_INCREMENT,
  `id_projet_multi_equipe` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `date_creation` DATETIME NOT NULL,
  `logo` VARCHAR(45) NULL,
  INDEX `fk_equipe_projet_multi_equipe1_idx` (`id_projet_multi_equipe` ASC),
  PRIMARY KEY (`id_equipe`),
  CONSTRAINT `fk_equipe_projet_multi_equipe1`
    FOREIGN KEY (`id_projet_multi_equipe`)
    REFERENCES `agriote_massy2016`.`projet_multi_equipe` (`id_projet_multi_equipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`seance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`seance` (
  `id_seance` INT NOT NULL AUTO_INCREMENT,
  `id_matiere` INT NOT NULL,
  `id_session` INT NOT NULL,
  `id_formateur` INT NOT NULL,
  `date_debut` DATETIME NOT NULL,
  `date_fin` DATETIME NOT NULL,
  `contenu` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_seance`),
  INDEX `fk_seance_matiere1_idx` (`id_matiere` ASC),
  INDEX `fk_seance_session1_idx` (`id_session` ASC),
  INDEX `fk_seance_formateur1_idx` (`id_formateur` ASC),
  CONSTRAINT `fk_seance_matiere1`
    FOREIGN KEY (`id_matiere`)
    REFERENCES `agriote_massy2016`.`matiere` (`id_matiere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seance_session1`
    FOREIGN KEY (`id_session`)
    REFERENCES `agriote_massy2016`.`session` (`id_session`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seance_formateur1`
    FOREIGN KEY (`id_formateur`)
    REFERENCES `agriote_massy2016`.`formateur` (`id_formateur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`matiere_has_formation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`matiere_has_formation` (
  `id_matiere` INT NOT NULL,
  `id_formation` INT NOT NULL,
  PRIMARY KEY (`id_matiere`, `id_formation`),
  INDEX `fk_matiere_has_formation_formation1_idx` (`id_formation` ASC),
  INDEX `fk_matiere_has_formation_matiere1_idx` (`id_matiere` ASC),
  CONSTRAINT `fk_matiere_has_formation_matiere1`
    FOREIGN KEY (`id_matiere`)
    REFERENCES `agriote_massy2016`.`matiere` (`id_matiere`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matiere_has_formation_formation1`
    FOREIGN KEY (`id_formation`)
    REFERENCES `agriote_massy2016`.`formation` (`id_formation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `agriote_massy2016`.`subsiste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agriote_massy2016`.`subsiste` (
  `id_equipe` INT NOT NULL,
  `id_membre` INT NOT NULL,
  `is_admin` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_equipe`, `id_membre`),
  INDEX `fk_equipe_has_membre_membre1_idx` (`id_membre` ASC),
  INDEX `fk_equipe_has_membre_equipe1_idx` (`id_equipe` ASC),
  CONSTRAINT `fk_equipe_has_membre_equipe1`
    FOREIGN KEY (`id_equipe`)
    REFERENCES `agriote_massy2016`.`equipe` (`id_equipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipe_has_membre_membre1`
    FOREIGN KEY (`id_membre`)
    REFERENCES `agriote_massy2016`.`membre` (`id_membre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET FOREIGN_KEY_CHECKS=1 $$



DROP PROCEDURE IF EXISTS reset_massy2016 $$
CREATE PROCEDURE reset_massy2016()
BEGIN
	-- Lever temporairement les contraintes d'intégrité
	SET FOREIGN_KEY_CHECKS=0;

  -- Vider les tables en remettant les auto-incréments à 0
	
        
        TRUNCATE TABLE bulletin;
        TRUNCATE TABLE candidature;
        TRUNCATE TABLE equipe;
        TRUNCATE TABLE etat_candidature;
        TRUNCATE TABLE evaluation;
        TRUNCATE TABLE formateur;
        TRUNCATE TABLE formation;
        TRUNCATE TABLE ligne_de_bulletin;
        TRUNCATE TABLE matiere;
        TRUNCATE TABLE matiere_has_formation;
        TRUNCATE TABLE membre;
        TRUNCATE TABLE note;
        TRUNCATE TABLE projet_multi_equipe;
        TRUNCATE TABLE seance;
        TRUNCATE TABLE session;
        TRUNCATE TABLE subsiste;
        
  -- etc, à vous de compléter

	-- Remettre les contraintes d'integrite
	SET FOREIGN_KEY_CHECKS=1;

  -- Insérer, dans un bloc capturant d'éventuelles exceptions
	BEGIN
    -- Indiquer que faire si une contrainte d'intégrité est violée
	  DECLARE EXIT HANDLER FOR SQLSTATE '23000'
	  BEGIN
      -- Annuler tout
      ROLLBACK;
      -- Afficher l'erreur
      SHOW ERRORS;
	  END;

    -- Démarrer la transaction et faire les insertions
		START TRANSACTION;
    -- Les insertions doivent respecter l'ordre des
    -- contraintes d'intégrité référentielles : si A fait référence à B,
    -- insérer B avant A.
    -- Exemple pour la syntaxe :

INSERT INTO membre
(id_membre, nom, prenom, mail, adresse, code_postal, ville, password, telephone, photo, admin) VALUES 
('1', 'BANKA', 'Joel', 'bankajoel@yahoo.fr', 'Ciel', '1110', 'Royaume', 'pipi', '0614787928', 'www.miroire.fr', '1'),
('2', 'BANKA', 'Junior', 'bankajunior@yahoo.fr', 'Ciel', '1100', 'Royaume', 'pipi', '0714787928', 'www.miroire.fr', '0'),
('3', 'BANKA', 'Joel Junior', 'bankajoeljunior@yahoo.fr', 'Ciel', '1000', 'Royaume', 'pipi', '614787928', 'www.miroire.fr', '1');


INSERT INTO matiere 
(id_matiere, intitule_matiere, nb_jour, description_matiere) VALUES 
('1', 'informatique_surnatural', '20', 'écrire des code capable de vous faire vivre sur la lune. haha'),
('2', 'hero_informatique', '20', 'hahahahahaha'),
('3', 'super_natural_info', '20', 'Tu pensais voir quoi ??. haha');


INSERT INTO formateur 
(id_formateur, id_matiere, id_membre, web_site) VALUES 
('1', '1', '1', 'neant'),
('2', '2', '2', 'neant'),
('3', '3', '3', 'neant');


INSERT INTO formation 
(id_formation, intitule_formation, description_formation) VALUES 
('1', 'BTS-SIO', ';-)');


INSERT INTO session 
(id_session, id_formation, date_debut, date_fin, nbr_places) VALUES 
('1', '1', '2015-06-01', '2016-05-30', '20');


INSERT INTO projet_multi_equipe 
(id_projet_multi_equipe, id_formateur, id_session, nom, description, date_creation, date_fin) VALUES 
('1', '3', '1', 'Chihuahua', 'Se transformer en super hero sur Jupiter pour éliminer les Chihuahua', '2016-02-17', '2016-02-18');


INSERT INTO equipe 
(id_equipe, id_projet_multi_equipe, nom, date_creation, logo) VALUES 
('1', '1', 'COBRA', '2016-02-17', ''),
('2', '1', 'ADVENGERS', '2016-02-18', '');


INSERT INTO `agriote_massy2016`.`subsiste` 
(`id_equipe`, `id_membre`, `is_admin`) VALUES 
('1', '1', '1'),
('1', '2', '0'),
('2', '3', '1');

    -- Valider la transaction
	  COMMIT;
	END;
END$$

CALL reset_massy2016()$$
