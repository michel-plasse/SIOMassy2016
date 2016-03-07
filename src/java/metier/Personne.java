package metier;

import java.util.Objects;


public class Personne {
    
    private String mail;//sert de login
    private String password;
    private String tel;
    private String nom;
    private String prenom;
    private String ville;
    private String adresse;
    private String codePostal;
    
    private String photo;//est actuellement une url
    private boolean est_admin = false;

    public Personne(String mail, String password) {
        this.mail = mail;
        this.password = password;
    }

    public Personne() {
        
    }

    public Personne(String mail, String password, String tel, String nom, String prenom, String ville, 
            String adresse, String codePostal, String photo) {
        this.mail = mail;
        this.password = password;
        this.tel = tel;
        this.nom = nom;
        this.prenom = prenom;
        this.ville = ville;
        this.adresse = adresse;
        this.codePostal = codePostal;
        this.photo = photo;
    }
    

    public String getMail() {
        return mail;
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
    
    public String getPhoto(){
        return photo;
    }

    public void setMail(String mail) {
        this.mail = mail;
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
    
    public void setPhoto(String photo){
        this.photo = photo;
    }
    

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 37 * hash + Objects.hashCode(this.mail);
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
        final Personne other = (Personne) obj;
        if (!Objects.equals(this.mail, other.mail)) {
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