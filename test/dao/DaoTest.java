package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.junit.Before;

/**
 * Classe parente de tous les tests unitaires de DAO.
 * Réinitialise la base dans son @Before, pour avoir
 * des données de départ toujours identiques.
 * @author plasse
 */
public class DaoTest {
  @Before
  public void resetDb() throws SQLException {
    System.out.println("Reninitialiser la base");
    Connection connexion = DbMassy2016.getConnection();
    String sql = "{ CALL reset_massy2016() }";
    CallableStatement ordre = connexion.prepareCall(sql);
    ordre.execute();
    ordre.close();
    connexion.close();
  }

}
