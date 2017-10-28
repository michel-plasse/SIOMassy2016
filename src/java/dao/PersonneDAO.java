package dao;

import metier.Personne;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import service.ServicePersonne;

public class PersonneDAO {

    /* Voir si les données saisies correspondent à une personne présente dans la base de données
     */
    public static Personne getByLoginPassword(String mail, String password) throws SQLException {
        Personne result = null;
        /*
         if("admin".equals(login) && "admin".equals(password)){
         result = new Personne(login,password);
         }
         */

        String sql = "SELECT * FROM personne WHERE mail=? AND password=?";

        Connection connection = DbMassy2016.getConnection();
        PreparedStatement ordre = connection.prepareStatement(sql);

        ordre.setString(1, mail);
        ordre.setString(2, password);
        ResultSet rs = ordre.executeQuery();
        if (rs.next()) {
            result = new Personne(mail, password);
        }
        return result;
    }

    /*
     * inserer une nouvelle personne dans la base de donnée
     */
    public static void insertPersonne(Personne personne) throws SQLException {

        String requete = "INSERT INTO personne (mail, "
                + "password, telephone, nom, prenom, ville, adresse, code_postal)VALUES (?,?,?,?,?,?,?,?)";

        Connection connection = DbMassy2016.getConnection();
        PreparedStatement ordre2 = connection.prepareStatement(requete);

        ordre2.setString(1, personne.getMail());
        ordre2.setString(2, personne.getPassword());
        ordre2.setString(3, personne.getTel());
        ordre2.setString(4, personne.getNom());
        ordre2.setString(5, personne.getPrenom());
        ordre2.setString(6, personne.getVille());
        ordre2.setString(7, personne.getAdresse());
        ordre2.setString(8, personne.getCodePostal());

//        String sql = "INSERT INTO personne(mail, password, telephone, nom, prenom, ville, adresse, code_postal) VALUES "
//                + "('"+personne.getMail() +"', '"+personne.getPassword()+"', '"+ personne.getTel() +"', '"+ personne.getNom() +"', '"
//                +personne.getPrenom()+"', '"+personne.getVille()+"', '"+personne.getAdresse()+"', '"+personne.getCodePostal()+"')";
//        
//        System.out.println(sql);
//        Connection connection = DbMassy2016.getConnection();
//        Statement ordre = connection.createStatement();
        ordre2.executeUpdate();
        ordre2.close();
        connection.close();
    }

    /*
     * Compare la personne qui se connecte avec un Formateur pour savoir si celle-ci est un formateur ou non
     */
    public static boolean isFormateur(int id) throws SQLException {

        String requete = "SELECT id_formateur FROM formateur WHERE id_formateur =" + id;

        Connection connection = DbMassy2016.getConnection();
        Statement ordre = connection.createStatement();
        ResultSet rs = ordre.executeQuery(requete);

        if (!rs.next()) {
            ordre.close();
            connection.close();
            return false;
        }
        ordre.close();
        connection.close();
        return true;
    }

    /*
     * Affiche une hashmap de personne en fonction d'une id_session  
     *
     * (continuer)
     */
    public static HashMap<Integer, Personne> getEleveBySession(int idSession) throws SQLException {

        HashMap<Integer, Personne> result = new HashMap<Integer, Personne>();
        String sql = "SELECT id_personne, nom, prenom"
                + " FROM stagiaire WHERE id_session = " + idSession;
        Connection connection = DbMassy2016.getConnection();

        Statement ordre = connection.createStatement();
        ResultSet rs = ordre.executeQuery(sql);

        while (rs.next()) {
            Personne personne = new Personne(rs.getString("nom"), rs.getString("prenom"), rs.getInt("id_personne"));
            result.put(rs.getInt("id_personne"), personne);
        }
        ordre.close();
        connection.close();

        return result;
    }

    //UNE HASHMAP POUR AVOIR LA LISTE DES SESSIONS AVEC L'INTITULE DE LA FORMATION (plus besoin)
    public static HashMap<String, Integer> getFormationBySession(int id_session) throws SQLException {

        HashMap<String, Integer> lesFormationsParSession = new HashMap<String, Integer>();

        Connection connexion = DbMassy2016.getConnection();

        String sql = "SELECT formation.intitule, session.id_session"
                + "FROM formation "
                + "INNER JOIN session ON formation.id_formation=session.id_formation "
                + "INNER JOIN seance ON session.id_session=seance.id_session "
                + "WEHER id_session = " + id_session;

        System.out.println(sql);
        Connection connection = DbMassy2016.getConnection();
        Statement ordre = connection.createStatement();

        ResultSet rs = ordre.executeQuery(sql);
        while (rs.next()) {
            lesFormationsParSession.put(rs.getString("formation.intitule"), id_session);

        }
        return lesFormationsParSession;
    }

}
