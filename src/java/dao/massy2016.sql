DELIMITER $$
DROP PROCEDURE IF EXISTS reset_massy2016 $$
CREATE PROCEDURE reset_massy2016()
BEGIN
	-- Lever temporairement les contraintes d'intégrité
	SET FOREIGN_KEY_CHECKS=0;

  -- Vider les tables en remettant les auto-incréments à 0
	TRUNCATE formation;
	TRUNCATE membre;
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
		INSERT INTO membre(login, password) VALUES
    ('Titi', 'gros minet'),
    ('Sylvestre', 'nom d''un chat');

    -- Valider la transaction
	  COMMIT;
	END;
END$$

CALL reset_massy2016()$$
