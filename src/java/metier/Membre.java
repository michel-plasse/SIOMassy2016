package metier;

import java.util.Objects;

/**
 * Membre de l'intranet : candidat, stagiaire, formateur, administration
 * @author plasse
 */
import java.util.Objects;


public class Membre {
    
    private String login;
    private String password;
    private String tel;
    private String nom;
    private String prenom;
    private String ville;
    private String adresse;
    private String codePostal;

    public Membre(String login, String password) {
        this.login = login;
        this.password = password;
    }

    public Membre() {
        
    }

    public Membre(String login, String password, String tel, String nom, String prenom, String ville, 
            String adresse, String codePostal) {
        this.login = login;
        this.password = password;
        this.tel = tel;
        this.nom = nom;
        this.prenom = prenom;
        this.ville = ville;
        this.adresse = adresse;
        this.codePostal = codePostal;
    }
    

    public String getLogin() {
        return login;
    }

    public String getPassword() {
        return password;
    }
    
    public String getTel() {
        return tel;
    }
    
    public String getNom(){
        return nom;
    }
    
    public String getPrenom(){
        return prenom;
    }
    
    public String getVille(){
        return ville;
    }
    
    public String getAdresse(){
        return adresse;
    }

    public String getCodePostal() {
        return codePostal;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public void setTel(String tel){
        this.tel = tel;
    }
    
    public void setNom(String nom){
        this.nom = nom;
    }
    
    public void setPrenom(String prenom){
        this.prenom = prenom;
    }
    
    public void setVille(String ville){
        this.ville = ville;
    }
    
    public void setAdresse(String adresse){
        this.adresse = adresse;
    }

    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    } 
    

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 37 * hash + Objects.hashCode(this.login);
        hash = 37 * hash + Objects.hashCode(this.password);
        hash = 37 * hash + Objects.hashCode(this.tel);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Membre other = (Membre) obj;
        if (!Objects.equals(this.login, other.login)) {
            return false;
        }
        if (!Objects.equals(this.password, other.password)) {
            return false;
        }
        if (!Objects.equals(this.tel, other.tel)) {
            return false;
        }
        return true;
    }
    
    
    
}
//  public String toString() {
//    return "Membre{" + "login=" + login + ", password=" + password + '}';
//  }

