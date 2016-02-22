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
  intitule VARCHAR(100) NOT NULL,
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
    (id_personne, nom, prenom, mail, adresse, code_postal, ville, password, telephone, photo, est_admin) VALUES
    (1, 'BANKA', 'Joel', 'bankajoel@yahoo.fr', 'Ciel', '11510', 'Royaume', 'pipi', '0614787928', null, 0),
    (2, 'GUIRASSI', 'Fode', 'sisi-senegal@gmail.com', '3, rue bidon', '95450', 'JeCestPas', '123', '0666835455', null, 0),
    (3, 'EFEKELE', 'Samuel', 'chacha@gmail.com', '2, rue du poulet-riz', '88600', 'JeuSaitPâs', 'Efekele+1', '0684556678', null, 0),
    (4, 'RODRIGUO', 'Bilanthini', 'bilan@hotmail.fr', '55, bv de rien', '96700', 'JeScaisTjrPas', 'BilanDeCompetences', '0796451731', null, 0),
    (5, 'BOISSEAU', 'Jordan', 'jordan@mail.com', '3 bis, rue du gars gentil', '91000', 'JaiPasDidée', '159', '0700700666', null, 0),
    (6,'ROUGIER','Dovan','dovan@agriote.fr','15 rue Dieu','75010','Paris','password','0123456789', null,1);
    INSERT INTO formation
    (id_formation, intitule, description) VALUES
    (1,"BTS Assistance Technique d'Ingénieur","Le titulaire de ce diplôme peut exercer des fonctions très variées :études, organisation, animation et formation, recherche et développement, production, gestion de production, gestion commerciale"),
    (2,"Technicien (ne) en systèmes de surveillance ","Installer, mettre en service et suivre techniquement un chantier d'installation en système de surveillance-intrusion et de vidéoprotection. Maintenir le sytème de surveillance intrusion d'habilitation et de locaux professionnels."),
    (3,"Bac S.T.I. : génie mécanique, génie électrotechnique","Assistance technique industrielle, Forgeage et estampage,Moulage, Étude d'outillage, Contrôle et régulation, Microtechnique, Maintenance et vente automobiles, Moteurs à combustion interne"),
    (4,"BTS Services Informatiques aux Organisations (S.I.O.) ","Le titulaire du BTS SIO travaille, soit en tant que collaborateur d’une organisation, soit en en tant qu'intervenant d'une société d’ingénierie et de services informatiques, d'un éditeur de logiciels, d'une société de conseil en technologies."),
    (5,"Licence Professionnelle Parcours Sécurité des réseaux et systèmes informatiques (LPSRSI)","La formation vise l’acquisition d’une double compétence informatique et juridique dans le domaine de la sécurité des réseaux et des systèmes informatiques."),
    (6,"Excel debutant","bonne formation pour debuter dans le monde d'office !");
    INSERT INTO module
    (id_module,intitule,nb_jours,description) VALUES
    (1,"Mathematiques",10,"Probabilites, statistiques"),
    (2,"Automatisme",15,"dans l'aeronautique"),
    (3,"Physique appliquée",35,"physique gros niveau"),
    (4,"Organisation industrielle",40,"organiser le fonctionnement"),
    (5,"Francais",18,"analyse de documents"),
    (6,"Mathematiques 2",35,"analyse, algebre"),
    (7,"Anglais",50,"niveau B2"),
    (8,"dessin technique",35,"dessin a l'aide de dao"),
    (9,"informatique",60,"javaEE: Application WEB"),
    (10,"Économie et gestion d'entreprise ",55,"economie de marche et synthese globale"),
    (11,"excel 1",10,"premiers pas pour faire des tableaux");
    INSERT INTO module_formation
    (id_module, id_formation) VALUES
    (1,1),
    (2,1),
    (3,1),
    (4,1),
    (6,1),
    (7,1),
    (8,1),
    (3,2),
    (4,2),
    (6,2),
    (8,2),
    (6,3),
    (7,3),
    (1,3),
    (5,3),
    (10,3),
    (1,4),
    (2,4),
    (4,4),
    (6,4),
    (3,5),
    (5,5),
    (6,5),
    (7,5),
    (9,5),
    (11,6);
    INSERT INTO session
    (id_session, id_formation, date_debut, date_fin, nb_places, date_debut_inscription, date_fin_inscription) VALUES
    (1, 4, '2016-06-17', '2017-06-12', 15, '2016-05-01', '2016-06-02'),
    (2, 6, '2016-08-22', '2016-10-18', 12, '2016-07-16', '2016-08-11'),
    (3, 1, '2016-10-10', '2017-09-15', 20, '2016-09-01', '2016-09-29'),
    (4, 5, '2016-11-25', '2017-11-09', 23, '2016-10-19', '2016-11-15'),
    (5, 2, '2017-01-05', '2017-11-02', 18, '2016-11-29', '2016-12-20'),
    (6, 3, '2017-02-10', '2017-12-20', 14, '2017-01-14', '2017-02-01');

 INSERT INTO etat_candidature
    (id_etat_candidature, intitule) VALUES
    (1, "en attente"),
    (2, "validée"),
    (3, "refusée");
    
    -- Valider la transaction
	  COMMIT;
	END;
END$$

CALL reset_massy2016()$$
 --- Créer l'utilisateur
 /** Supprime l'utilisateur avant de le créer */
 GRANT USAGE ON siomassy2016.* TO 'user_massy2016'@'localhost' IDENTIFIED BY 'pwd_massy2016'$$
 DROP USER 'user_massy2016'@'localhost'$$
 /** Creer l'utilisateur et lui donner tous les droits */
 CREATE USER 'user_massy2016'@'localhost' IDENTIFIED BY 'pwd_massy2016'$$
 GRANT ALL ON siomassy2016.* TO 'user_massy2016'@'localhost'$$
 GRANT SELECT ON mysql.proc TO 'user_massy2016'@'localhost'$$
 
