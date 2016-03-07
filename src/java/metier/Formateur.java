package metier;

/**
 *
 * @author Vincent Moreau
 */
public class Formateur extends Personne {
    private String sitePersonnel; //ajoute une ligne pour un site perso du formateur

    //création d'un formateur

    public Formateur(String sitePersonnel, String mail, String password, String tel, String nom, String prenom, String ville, String adresse, String codePostal, String photo) {
        super(mail, password, tel, nom, prenom, ville, adresse, codePostal, photo);
        this.sitePersonnel = sitePersonnel;
    }
  

    public String getSitePersonnel() {
        return sitePersonnel;
    }

    public void setSitePersonnel(String sitePersonnel) {
        this.sitePersonnel = sitePersonnel;
    }
 

}
