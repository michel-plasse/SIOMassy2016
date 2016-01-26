DELIMITER $$
CREATE PROCEDURE reset_massy2016()
BEGIN
  TRUNCATE TABLE membre;
  INSERT INTO membre(login, password) VALUES
	('Titi', 'gros minet'),
	('Sylvestre', 'nom d''un chat');
END$$

CALL reset_massy2016()$$
