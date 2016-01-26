package dao;

import metier.Membre;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author plasse
 */
public class MembreDAOTest extends DaoTest {

  @Test
  public void testGetByLoginPassword() throws Exception {
    System.out.println("getByLoginPassword");
    String login = "Titi";
    String password = "gros minet";
    Membre expResult = new Membre(login, password);
    Membre result = MembreDAO.getByLoginPassword(login, password);
    assertEquals(expResult, result);
  }
  @Test
  public void testGetByLoginPasswordPasTrouve() throws Exception {
    System.out.println("getByLoginPassword");
    String login = "Machin";
    String password = "bidule";
    Membre result = MembreDAO.getByLoginPassword(login, password);
    assertNull(result);
  }

  @Test
  public void testGetAll() throws Exception {
    System.out.println("getAll");
    List<Membre> expected = new ArrayList<Membre>();
    expected.add(new Membre("Sylvestre", "nom d'un chat"));
    expected.add(new Membre("Titi", "gros minet"));
    assertEquals(expected, MembreDAO.getAll());
  }
}
