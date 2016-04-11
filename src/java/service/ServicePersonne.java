package service;

import metier.Personne;
import dao.DbMassy2016;
import dao.PersonneDAO;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;


public class ServicePersonne {
    
   public static Personne getByLoginPassword(String mail, String password)throws SQLException{
       Personne p1 = new Personne(mail, password);
       PersonneDAO.getByLoginPassword(mail, password);
       return p1;
   }
               

    
   public static void insertPersonne(Personne personne)throws SQLException{
      PersonneDAO.insertPersonne(personne);
   }
   
   
   public static boolean isFormateur(int id)throws SQLException{
       PersonneDAO.isFormateur(id);
       return true;
   }
   
//   public  HashMap<Integer, String> getFormationBySession(int id_personne) throws SQLException{
//       
//   }
   
//   public List <Personne> getEleveBySession(int id) throws SQLException{
//       
//   }
   
    
}
