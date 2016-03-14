/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import metier.Membre;
import dao.PersonneDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author plasse
 */
@WebServlet(name = "Connexion", urlPatterns = {"/connexion"})
public class ConnexionServlet extends HttpServlet {

  /**
   * Handles the HTTP <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request,
      HttpServletResponse response)
      throws ServletException, IOException {
    // Passer la main à index.jsp
    request.getRequestDispatcher("index.jsp").forward(request, response);
  }

  /**
   * Handles the HTTP <code>POST</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request,
      HttpServletResponse response)
      throws ServletException, IOException {
    // Recuperer la saisie
    String login = request.getParameter("login");
    String password = request.getParameter("password");
    try {
      // Faire appel au modèle
      Membre membre = PersonneDAO.getByLoginPassword(login, password);
      if (membre == null) { // Utilisateur pas connu
        // AJouter un post-it loginMsg comme message d'erreur
        request.setAttribute("loginMsg", "Utilisateur inconnu ou mot de passe erronné");
        request.getRequestDispatcher("index.jsp").forward(request, response);
      }
      else {
        // Le mettre en session
        request.getSession(true).setAttribute("membre", membre);
        // Mettre en post-it le membre
        request.setAttribute("membre", membre);
        request.getRequestDispatcher("WEB-INF/profil.jsp").forward(request, response);
      }
    }
    catch (SQLException ex) {
      Logger.getLogger(ConnexionServlet.class.getName()).log(Level.SEVERE, null, ex);
      request.setAttribute("loginMsg", ex.getMessage());
      request.getRequestDispatcher("index.jsp").forward(request, response);
    }
  }

  /**
   * Returns a short description of the servlet.
   *
   * @return a String containing servlet description
   */
  @Override
  public String getServletInfo() {
    return "Short description";
  }// </editor-fold>

}
