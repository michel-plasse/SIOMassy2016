package metier;

import java.util.Objects;

/**
 * Membre de l'intranet : candidat, stagiaire, formateur, administration
 * @author plasse
 */
public class Membre {
  private String login;
  private String password;

  public Membre(String login, String password) {
    this.login = login;
    this.password = password;
  }

  public String getLogin() {
    return login;
  }

  public void setLogin(String login) {
    this.login = login;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  @Override
  public int hashCode() {
    int hash = 3;
    hash = 11 * hash + Objects.hashCode(this.login);
    hash = 11 * hash + Objects.hashCode(this.password);
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
    return true;
  }

  @Override
  public String toString() {
    return "Membre{" + "login=" + login + ", password=" + password + '}';
  }

}
