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
  telephone VARCHAR(45) NOT NULL,
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
  date_effet DATE NOT NULL,
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
  date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
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

---- Vue Stagiaire

DROP VIEW IF EXISTS stagiaire $$
CREATE VIEW stagiaire AS
    SELECT 
        p.id_personne AS id_personne,
        nom,
        prenom,
        mail,
        adresse,
        code_postal,
        ville,
        password,
        telephone,
        photo,
        est_admin,
        id_session,
        date_candidature
    FROM
        candidature c
		INNER JOIN personne p 
		ON p.id_personne = c.id_membre
    WHERE
        id_etat_candidature = 2 $$

---- Fin vue


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
    (1, 'BANKA', 'Joel', 'bankajoel@yahoo.fr', '7 rue de chateau deau', '91130', 'Ris-Orangis', 'pipi', '06 14 78 79 28', null, 0),
    (2, 'GUIRASSI', 'Fode', 'sisi-senegal@gmail.com', '1 rue Léon Blum', '91130', 'Ris-Orangis', '123', '06 66 83 54 55', null, 0),
    (3, 'EFEKELE', 'Samuel', 'chacha@gmail.com', '17 avenue Auguste Plat', '91130', 'Ris-Orangis', 'Efekele+1', '06 84 55 66 78', null, 0),
    (4, 'RODRIGUO', 'Bilanthini', 'bilan@greta.fr', '10 rue de Bretagne', '91130', 'Ris-Orangis', 'mapoule', '07 96 45 17 31', null, 0),
    (5, 'BOISSEAU', 'Jordan', 'jordan@mail.com', '1 avenue de la gare', '91130', 'Ris-Orangis', '159', '07 00 70 06 66', null, 0),
    (6, 'MOREAU', 'Vincent', 'vince@greta.fr', '13 rue de Girouise', '91360', 'Épinay-sur-Orge', '321', '06 35 84 96 32', null, 0),
    (7, 'ROUGIER', 'Dovan', 'dovan@agriote.fr', '15 rue Dieu', '75010', 'Paris', 'password', '01 23 45 67 89', null, 1),
    (8, 'PERRIN', 'Sandrine', 'sancrine@greta.fr', '7 place du parc aux lièvres' , '91000', 'Evry', '753', '06 31 25 57 74', null, 0),
    (9, 'MBENDA', 'Lionel', 'lionel@greta.fr', '10 allée de bonhomme en pierre', '91000', 'Evry', '357', '07 48 63 14 55', null, 0),
    (10, 'MARC', 'Mickael', 'mickael@agriote.fr', '24 rue de la futaie', '91090', 'Lisses', '951', '07 47 55 12 18 13', null, 0),
    (11, 'JOYEUX', 'Jerome', 'jerome@agriote.fr', '9 rue de Vlaminck', '91350', 'Grigny', 'mdp', '07 37 45 45 11', null, 0),
    (12, 'MOSHINE', 'Hajar', 'hajar@greta.fr', '10 rue Léonard De Vinci', '91090', 'Lisses', 'motdepasse', '06 99 88 13 13', null, 0),
    (13, 'BOURDET', 'Eric', 'eric@gmail.com', '5 rue Saint Exupéry', '91070', 'Bondoufle', 'pwd', '06 13 54 78 96', null, 0),
    (14, 'GROLEAS', 'Brigitte', 'brigitte@agriote.fr', '6 rue Jean Meremoz', '91080', 'Courcouronnes', 'netbeans', '06 96 85 51 43', null, 1),
    (15, 'PLASSE', 'Michel', 'michel@greta.fr', '9 rue des Petits Champs', '91100', 'Villabé', 'eclipse', '06 57 16 83 57', null, 1),
    (16, 'COURTO', 'Blanche', 'blanche@greta.fr', '5 rue du Louvre', '75001', 'Paris', 'voltaire', '07 88 33 45 14', null, 0),
    (17, 'DUGLAND', 'Sebastien', 'sebastien@greta.fr', '11 avenue de Breteuil', '75007', 'Paris', 'mdp123', '07 54 14 37 86', null, 0),
    (18, 'DUPOND', 'Dupond', 'dupond@greta.fr', '15 rue Legendre', '75017', 'Paris', 'dupontpwd', '06 68 97 31 16', null, 0),
    (19, 'TIN', 'Tin', 'tintin@gmail.com', '2 rue de Belleville', '75020', 'Paris', 'milou', '06 54 57 73 24', null, 0),
    (20, 'HANOUNA', 'Cyril', 'cyril@greta.fr', '9 rue du Chevaleret', '75013' ,'Paris', 'baba', '06 13 91 67 35', null, 0),
    (21, 'LOUVIN', 'Gérard', 'gérard@agriote.fr', '7 rue Hardy', '78000', 'Versailles', 'tulavus', '06 81 68 15 73', null, 0),
    (22, 'COMBAL', 'Camille', 'camille@gmail.com', '8 rue Saint-Louis', '78300', 'Poissy', 'cyrilhanouna', '07 13 91 35 67', null, 0),
    (23, 'DEPP', 'Johnny', 'johnny@greta.fr', '17 rue Edouard Robert', '91290', 'Arpajon', 'rhum', '06 97 64 31 28', null, 0),
    (24, 'BENATTIA', 'Nabilla', 'nabilla@free.fr', '23 rue Victor Hugo', '91290', 'Arpajon', 'allo', '06 11 22 33 44', null, 0),
    (25, 'DIESIEL', 'Vin', 'vin@gmail.com', '3 rue Docteur Roux', '91160', 'Longjumeau', 'babysitor', '07 31 46 79 58', null, 0);
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
    
    INSERT INTO formateur
    (id_formateur,site_web)VALUES
    (14,"www.mplasse.com"),
    (15,"www.algob.fr"),
    (23,""),
    (24,""),
    (18,"");
    
    INSERT INTO intervenant
    (id_module, id_personne) VALUES
    (1,14),
    (2,15),
    (3,23),
    (4,24),
    (6,23),
    (9,14),
    (9,15),
    (5,18);
    
    INSERT INTO seance
    (id_seance, id_module, id_session, id_formateur, jour) VAlUES
    (1,9,4,14,'2016-11-25'),
    (2,9,4,15,'2016-11-26'),
    (3,3,3,23,'2016-11-25'),
    (4,5,6,18,'2017-02-13'),
    (5,4,5,24,'2017-01-06');
    
    INSERT INTO projet
    (id_projet,id_formateur,id_session,nom,description,date_creation,date_fin)VALUES
    (1,14,1,"Project Code source","Le but de ce projet c'est de tester github",'2016-09-12','2016-10-15 17:00'),
    (2,14,3,"Le réseau","Ce projet consiste à créer un réseau social par équipe",'2016-12-12','2017-02-15 18:30'),
    (3,24,1,"Communication","Savoir communiquer en bon français",'2017-03-12','2017-04-22 13:30');
    
    INSERT INTO bilan 
    (id_bilan,id_session,date_effet) VALUES
    (1,1,'2016-12-01'),
    (2,1,'2017-06-01'),
    (3,2,'2016-12-22'),
    (4,2,'2017-12-24');

    INSERT INTO bulletin
    (id_personne, id_bilan, commentaire) VALUES
    (1,1,"Joel devrait s'investir plus en classe plutot que de s'occuper du PSG"),
    (2,1,"Fodé est un élève très investit"),
    (3,1,"Samuel fournit beaucoup d'effort! Continuez ainsi"),
    (4,1,"Bilanthini est l'élève la plus agréable avec laquelle il m'a été donné de travailler");
    
     INSERT INTO evaluation
    (id_evaluation,id_session,id_module,id_formateur,date_effet,commentaire)VALUES
    (1,1,1,18,'2016-03-10',"apportez vos calculettes !"),
    (2,2,2,23,'2016-04-15',"révisez vos schéma structurels "),
    (3,3,3,24,'2016-05-18',"U=RxI"),
    (4,4,4,15,'2016-06-25',"révisez les suites "),
    (5,5,5,23,'2017-02-05',"écriture perso tout les auteurs s'accordetn à dire..."),
    (6,6,6,15,'2017-05-06',"bon courage"),
    (7,1,7,18,'2016-04-12',"calm down !!! "),
    (8,1,9,14,'2016-03-20',"révisez le JEE"),
    (9,1,10,23,'2016-03-10',"révisez les contrats de travail");

INSERT INTO candidature
    (id_membre,id_session,id_etat_candidature,date_candidature) VALUES
    (1,1,2,'2016-02-17'),
    (2,2,1,'2016-03-20'),
    (3,3,2,'2016-05-12'),
    (4,4,2,'2016-06-12'),
    (5,5,3,'2016-11-10'),
    (6,6,3,'2016-10-15'),
    (7,1,1,'2016-03-16'),
    (8,2,2,'2016-05-18'),
    (9,3,3,'2016-05-18'),
    (10,4,1,'2016-07-02'),
    (11,5,2,'2016-01-20'),
    (12,6,3,'2016-09-05'),
    (13,1,1,'2016-03-28'),
    (14,2,2,'2016-04-21'),
    (15,3,3,'2016-05-20'),
    (16,4,1,'2016-06-17'),
    (17,5,2,'2016-08-13'),
    (18,6,3,'2016-09-01'),
    (19,1,1,'2016-10-20');

INSERT INTO equipe
    (id_equipe, id_projet) VALUES 
    ('1', '1'),
    ('2', '1'),
    ('3', '1'),
    ('4', '2'),
    ('5', '2'),
    ('6', '3');

INSERT INTO membre 
    (id_equipe, id_personne, est_createur) VALUES 
    ('1', '1', '1'),
    ('1', '2', '0'),
    ('1', '3', '0'),
    ('2', '4', '1'),
    ('2', '5', '0'),
    ('2', '6', '0'),
    ('3', '7', '1'),
    ('4', '2', '1'),
    ('4', '5', '0'),
    ('4', '7', '0'),
    ('5', '9', '1'),
    ('6', '1', '1'),
    ('6', '6', '0');

INSERT INTO note
    (id_evaluation, id_personne, note) VALUES
    (1, 1, 10),
    (1, 2, 15),
    (1, 3, 12),
    (1, 4, 8),
    (2, 1, 0),
    (2, 2, 10),
    (2, 3, 12),
    (2, 4, 13),
    (3, 1, 17),
    (3, 2, 0),
    (3, 3, 10),
    (3, 4, 0);


   
    
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
 
