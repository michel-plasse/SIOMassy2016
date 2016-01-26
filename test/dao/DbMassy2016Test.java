package dao;

import java.sql.Connection;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author plasse
 */
public class DbMassy2016Test {

  @Test
  public void testGetConnection() throws Exception {
    System.out.println("getConnection");
    Connection result = DbMassy2016.getConnection();
    assertNotNull(result);
  }

}
