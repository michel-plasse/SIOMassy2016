DELIMITER $$
DROP SCHEMA IF EXISTS siomassy2016 $$
CREATE SCHEMA IF NOT EXISTS siomassy2016 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci $$
USE siomassy2016 $$

CREATE TABLE IF NOT EXISTS personne (
  id_personne INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  prenom VARCHAR(45) NOT NULL,
  mail VARCHAR(45) NOT NULL,
  adresse VARCHAR(45) NOT NULL,
  code_postal VARCHAR(5) NOT NULL,
  ville VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  telephone INT NOT NULL,
  photo VARCHAR(45) NULL,
  est_admin TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (id_personne))
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS formateur (
  id_formateur INT NOT NULL,
  site_web VARCHAR(100) NULL,
  INDEX fk_formateur_membre1_idx (id_formateur ASC),
  PRIMARY KEY (id_formateur),
  CONSTRAINT fk_formateur_personne
    FOREIGN KEY (id_formateur)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS module (
  id_module INT NOT NULL AUTO_INCREMENT,
  intitule VARCHAR(45) NOT NULL,
  nb_jours INT NOT NULL,
  description VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_module))
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS formation (
  id_formation INT NOT NULL AUTO_INCREMENT,
  intitule VARCHAR(45) NOT NULL,
  description VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_formation))
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS session (
  id_session INT NOT NULL AUTO_INCREMENT,
  id_formation INT NOT NULL,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  nb_places INT NOT NULL,
  date_debut_inscription DATE NOT NULL,
  date_fin_inscription DATE NOT NULL,
  PRIMARY KEY (id_session),
  INDEX fk_session_formation1_idx (id_formation ASC),
  CONSTRAINT fk_session_formation1
    FOREIGN KEY (id_formation)
    REFERENCES formation (id_formation)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS projet (
  id_projet INT NOT NULL AUTO_INCREMENT,
  id_formateur INT NOT NULL,
  id_session INT NOT NULL,
  nom VARCHAR(45) NOT NULL,
  description VARCHAR(200) NOT NULL,
  date_creation DATE NOT NULL,
  date_fin DATETIME NOT NULL,
  PRIMARY KEY (id_projet),
  INDEX fk_projet_multi_equipe_session1_idx (id_session ASC),
  INDEX fk_projet_formateur_idx (id_formateur ASC),
  CONSTRAINT fk_projet_session
    FOREIGN KEY (id_session)
    REFERENCES session (id_session)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_projet_formateur
    FOREIGN KEY (id_formateur)
    REFERENCES formateur (id_formateur)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS bilan (
  id_bilan INT NOT NULL AUTO_INCREMENT,
  id_session INT NOT NULL,
  PRIMARY KEY (id_bilan),
  INDEX fk_bilan_session1_idx (id_session ASC),
  CONSTRAINT fk_bilan_session1
    FOREIGN KEY (id_session)
    REFERENCES session (id_session)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS bulletin (
  id_personne INT NOT NULL,
  id_bilan INT NOT NULL,
  commentaire VARCHAR(250) NOT NULL,
  INDEX fk_bulletin_membre1_idx (id_personne ASC),
  PRIMARY KEY (id_personne, id_bilan),
  INDEX fk_bulletin_bilan1_idx (id_bilan ASC),
  CONSTRAINT fk_bulletin_membre
    FOREIGN KEY (id_personne)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_bulletin_bilan
    FOREIGN KEY (id_bilan)
    REFERENCES bilan (id_bilan)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS evaluation (
  id_evaluation INT NOT NULL AUTO_INCREMENT,
  id_session INT NOT NULL,
  id_module INT NOT NULL,
  id_formateur INT NOT NULL,
  date_effet DATETIME NOT NULL,
  commentaire VARCHAR(200) NULL,
  PRIMARY KEY (id_evaluation),
  INDEX fk_evaluation_session1_idx (id_session ASC),
  INDEX fk_evaluation_matiere1_idx (id_module ASC),
  INDEX fk_evaluation_formateur_idx (id_formateur ASC),
  CONSTRAINT fk_evaluation_session1
    FOREIGN KEY (id_session)
    REFERENCES session (id_session)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evaluation_matiere1
    FOREIGN KEY (id_module)
    REFERENCES module (id_module)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evaluation_formateur
    FOREIGN KEY (id_formateur)
    REFERENCES formateur (id_formateur)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS etat_candidature (
  id_etat_candidature INT NOT NULL AUTO_INCREMENT,
  intitule VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_etat_candidature))
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS candidature (
  id_membre INT NOT NULL AUTO_INCREMENT,
  id_session INT NOT NULL,
  id_etat_candidature INT NOT NULL,
  date_candidature DATETIME NOT NULL,
  PRIMARY KEY (id_membre, id_session),
  INDEX fk_membre_has_session_session1_idx (id_session ASC),
  INDEX fk_membre_has_session_membre_idx (id_membre ASC),
  INDEX fk_membre_has_session_etat_candidature1_idx (id_etat_candidature ASC),
  CONSTRAINT fk_membre_has_session_membre
    FOREIGN KEY (id_membre)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_membre_has_session_session1
    FOREIGN KEY (id_session)
    REFERENCES session (id_session)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_membre_has_session_etat_candidature1
    FOREIGN KEY (id_etat_candidature)
    REFERENCES etat_candidature (id_etat_candidature)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS ligne_bulletin (
  id_formateur INT NOT NULL,
  commentaire VARCHAR(100) NULL,
  id_personne INT NOT NULL,
  id_bilan INT NOT NULL,
  id_module INT NOT NULL,
  PRIMARY KEY (id_formateur, id_personne, id_bilan, id_module),
  INDEX fk_ligne_bulletin_formateur1_idx (id_formateur ASC),
  INDEX fk_ligne_bulletin_bulletin1_idx (id_personne ASC, id_bilan ASC),
  INDEX fk_ligne_bulletin_module1_idx (id_module ASC),
  CONSTRAINT fk_ligne_bulletin_formateur
    FOREIGN KEY (id_formateur)
    REFERENCES formateur (id_formateur)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ligne_bulletin_bulletin1
    FOREIGN KEY (id_personne , id_bilan)
    REFERENCES bulletin (id_personne , id_bilan)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ligne_bulletin_module1
    FOREIGN KEY (id_module)
    REFERENCES module (id_module)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS note (
  id_evaluation INT NOT NULL,
  id_personne INT NOT NULL,
  note INT NOT NULL,
  INDEX fk_note_evaluation1_idx (id_evaluation ASC),
  INDEX fk_note_membre1_idx (id_personne ASC),
  PRIMARY KEY (id_evaluation, id_personne),
  CONSTRAINT fk_note_evaluation1
    FOREIGN KEY (id_evaluation)
    REFERENCES evaluation (id_evaluation)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_note_membre1
    FOREIGN KEY (id_personne)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS equipe (
  id_equipe INT NOT NULL AUTO_INCREMENT,
  id_projet INT NOT NULL,
  date_creation DATETIME NOT NULL,
  PRIMARY KEY (id_equipe),
  INDEX fk_equipe_projet_multi_equipe1_idx (id_projet ASC),
  CONSTRAINT fk_equipe_projet
    FOREIGN KEY (id_projet)
    REFERENCES projet (id_projet)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS seance (
  id_seance INT NOT NULL AUTO_INCREMENT,
  id_module INT NOT NULL,
  id_session INT NOT NULL,
  id_formateur INT NOT NULL,
  jour DATE NOT NULL,
  contenu VARCHAR(45) NULL,
  PRIMARY KEY (id_seance),
  INDEX fk_seance_matiere1_idx (id_module ASC),
  INDEX fk_seance_session1_idx (id_session ASC),
  UNIQUE INDEX seance_jour_session_formateur_unique (jour ASC, id_session ASC, id_formateur ASC),
  UNIQUE INDEX seance_jour_session_module_unique (jour ASC, id_session ASC, id_module ASC),
  INDEX fk_seance_formateur_idx (id_formateur ASC),
  CONSTRAINT fk_seance_matiere
    FOREIGN KEY (id_module)
    REFERENCES module (id_module)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_seance_session
    FOREIGN KEY (id_session)
    REFERENCES session (id_session)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_seance_formateur
    FOREIGN KEY (id_formateur)
    REFERENCES formateur (id_formateur)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS module_formation (
  id_module INT NOT NULL,
  id_formation INT NOT NULL,
  PRIMARY KEY (id_module, id_formation),
  INDEX fk_matiere_has_formation_formation1_idx (id_formation ASC),
  INDEX fk_matiere_has_formation_matiere1_idx (id_module ASC),
  CONSTRAINT fk_matiere_has_formation_matiere1
    FOREIGN KEY (id_module)
    REFERENCES module (id_module)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_matiere_has_formation_formation1
    FOREIGN KEY (id_formation)
    REFERENCES formation (id_formation)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS intervenant (
  id_module INT NOT NULL,
  id_personne INT NOT NULL,
  PRIMARY KEY (id_module, id_personne),
  INDEX fk_module_has_formateur_formateur1_idx (id_personne ASC),
  INDEX fk_module_has_formateur_module1_idx (id_module ASC),
  CONSTRAINT fk_module_has_formateur_module1
    FOREIGN KEY (id_module)
    REFERENCES module (id_module)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_module_has_formateur_formateur1
    FOREIGN KEY (id_personne)
    REFERENCES formateur (id_formateur)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$


CREATE TABLE IF NOT EXISTS membre (
  id_equipe INT NOT NULL,
  id_personne INT NOT NULL,
  est_createur TINYINT(1) NOT NULL DEFAULT false,
  PRIMARY KEY (id_equipe, id_personne),
  INDEX fk_membe_personne (id_personne ASC),
  INDEX fk_membre_equipe (id_equipe ASC),
  CONSTRAINT fk_equipe_has_personne_equipe1
    FOREIGN KEY (id_equipe)
    REFERENCES equipe (id_equipe)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_equipe_has_personne_personne1
    FOREIGN KEY (id_personne)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB$$




DROP PROCEDURE IF EXISTS reset_massy2016 $$
CREATE PROCEDURE reset_massy2016()
BEGIN
	-- Lever temporairement les contraintes d'intégrité
	SET FOREIGN_KEY_CHECKS=0;

  -- Vider les tables en remettant les auto-incréments à 0
  TRUNCATE TABLE bilan;
  TRUNCATE TABLE bulletin;
  TRUNCATE TABLE candidature;
  TRUNCATE TABLE equipe;
  TRUNCATE TABLE etat_candidature;
  TRUNCATE TABLE evaluation;
  TRUNCATE TABLE formateur;
  TRUNCATE TABLE formation;
  TRUNCATE TABLE intervenant;
  TRUNCATE TABLE ligne_bulletin;
  TRUNCATE TABLE membre;
  TRUNCATE TABLE module;
  TRUNCATE TABLE module_formation;
  TRUNCATE TABLE note;
  TRUNCATE TABLE personne;
  TRUNCATE TABLE projet;
  TRUNCATE TABLE seance;
  TRUNCATE TABLE session;

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
    INSERT INTO personne
    (id_personne, nom, prenom, mail, adresse, code_postal, ville, password, telephone, photo, admin) VALUES
    ('1', 'BANKA', 'Joel', 'bankajoel@yahoo.fr', 'Ciel', '1110', 'Royaume', 'pipi', '0614787928', 'www.miroire.fr', '1');


    -- Valider la transaction
	  COMMIT;
	END;
END$$

CALL reset_massy2016()$$
