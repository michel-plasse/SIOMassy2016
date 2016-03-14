package dao;

import metier.Membre;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


import metier.Membre;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PersonneDAO {
    

    public static Personne getByLoginPassword(String login, String password) throws SQLException {
        Personne result = null;
        /*if("admin".equals(login) && "admin".equals(password)){
         result = new Member(login,password);
         }*/
        
        //String requete = "SELECT * FROM membre WHERE login='" + login + "'AND password='" + password + "'";
        //une autre façon de faire
        String sql="SELECT * FROM membre WHERE login=? AND password=?";
        Connection connection = DbMassy2016.getConnection();
        
        //Statement ordre = connection.createStatement();
        PreparedStatement ordre = connection.prepareStatement(sql);
        ordre.setString(1, login);
        ordre.setString(2, password);
        ResultSet rs = ordre.executeQuery();
        if (rs.next()) {
            result = new Membre(login, password);
        }

        return result;
    }
    
    public static void insert(Membre membre) throws SQLException{
        
        String sql = "INSERT INTO membre(login, password, tel, nom, prenom, ville, adresse, codePostal) VALUES "
                + "('"+membre.getLogin() +"', '"+ membre.getPassword()+"', '"+ membre.getTel() +"', '"+ membre.getNom() +"', '"
                      +membre.getPrenom()+"', '"+membre.getVille()+"', '"+membre.getAdresse()+"', '"+membre.getCodePostal()+"')";
        System.out.println(sql);
        Connection connection = DbMassy2016.getConnection();
        Statement ordre = connection.createStatement();
        ordre.executeUpdate(sql);
        ordre.close();
        connection.close();
    }

    public static List<Membre> getAll() throws SQLException{
        
        List<Membre> result = new ArrayList<Membre>();
        String sql = "SELECT * FROM membre ORDER BY login";
        
        System.out.println(sql);
        Connection connection = DbMassy2016.getConnection();
        
        Statement ordre = connection.createStatement();
        ResultSet rs = ordre.executeQuery(sql);
        
        while(rs.next()){
            Membre member = new Membre(rs.getString("login"),rs.getString("password"));
            result.add(member);
        }
        ordre.close();
        
        return result;
    }

}

///**
// * Version minimaliste de l'accès BD pour les membres. A revoir ...
// */
//public class PersonneDAO {
//  /** Membre de login et mot de passe indiqué. Null si pas trouvé
//   *
//   * @param login
//   * @param password
//   * @return
//   * @throws SQLException
//   */
//  public static Membre getByLoginPassword(String login,
//      String password) throws SQLException {
//    Membre result = null;
//    String sql = "SELECT * FROM membre WHERE login=? AND password=?";
//    Connection connection = DbMassy2016.getConnection();
//    PreparedStatement ordre = connection.prepareStatement(sql);
//    ordre.setString(1, login);
//    ordre.setString(2, password);
//    ResultSet rs = ordre.executeQuery();
//    if (rs.next()) {
//      result = new Membre(login, password);
//    }
//    return result;
//  }
//
//  /** Ensemble des membres. Si aucun, fournit une liste vide.
//   * A revoir pour renvoyer les données par blocs. Prévoir d'autres fonctions
//   * avec critères de recherche, voire tri.
//   * @return
//   * @throws SQLException
//   */
//  public static List<Membre> getAll() throws SQLException {
//    List<Membre> result = new ArrayList<Membre>();
//    Connection connection = DbMassy2016.getConnection();
//    String sql = "SELECT * FROM membre ORDER BY login";
//    Statement ordre = connection.createStatement();
//    ResultSet rs = ordre.executeQuery(sql);
//    while (rs.next()) {
//      Membre membre = new Membre(rs.getString("login"),
//          rs.getString("password"));
//      result.add(membre);
//    }
//    return result;
//  }
//}


