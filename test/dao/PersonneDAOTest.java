package dao;

import metier.Personne;
import java.util.ArrayList;
import java.util.List;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author plasse
 */
public class PersonneDAOTest extends DaoTest {

  @Test
  public void testGetByLoginPassword() throws Exception {
    System.out.println("getByLoginPassword");
    String login = "Titi";
    String password = "gros minet";
    Personne expResult = new Personne(login, password);
    Personne result = PersonneDAO.getByLoginPassword(login, password);
    assertEquals(expResult, result);
  }
  @Test
  public void testGetByLoginPasswordPasTrouve() throws Exception {
    System.out.println("getByLoginPassword");
    String login = "Machin";
    String password = "bidule";
    Personne result = PersonneDAO.getByLoginPassword(login, password);
    assertNull(result);
  }

  @Test
  public void testGetAll() throws Exception {
    System.out.println("getAll");
    List<Personne> expected = new ArrayList<Personne>();
    expected.add(new Personne("Sylvestre", "nom d'un chat"));
    expected.add(new Personne("Titi", "gros minet"));
    assertEquals(expected, PersonneDAO.getAll());
  }
}
