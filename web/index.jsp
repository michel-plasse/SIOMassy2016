<%--
    Document   : index
    Created on : 8 janv. 2016, 15:39:29
    Author     : plasse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <nav>
      <form action="connexion" method="POST">
        Login
        <input type="text" name="login" value="${param['login']}"/>
        pwd
        <input type="password" name="password"/>
        <button type="submit">Connecter</button>
        ${loginMsg}
      </form>
    </nav>
    <section>
      <ol>
        <li>Connexion/déconnexion <em>Sandrine et Vincent</em></li>
        <li><a href="inscription">S'inscrire</a> <em>Hajar et Jordan</em></li>
        <li><a href="candidater?idSession=1">Candidater à la
            session 1</a> <em>Lionel</em></li>
        <li><a href="gererCandidatures?idSession=1">Gérer les
            candidatures de la session 1</a> <em>Fodé et Jérôme</em>
        </li>
        <li><a href="rappelMotDePasse">Rappel du mot de passe</a>
          <em>Eric</em>
        </li>
        <li><a href="trombinoscope?idSession=1">Trombinoscope de
            la session 1</a> <em>Bilanthini et Mickaël</em></li>
        <li><a href="modifierProfil">Modifier son profil</a>
          (d'abord l'utilisateur 1) <em>Fodé et Hajar</em>
        </li>
        <li><a href="projet/nouveau?idSession=1">Créer un projet
            multi-équipes dans la session 1</a> (réservé
          aux formateurs) <em>Samuel</em>
        </li>
        <li><a href="creerEquipe?idProjet=1">Créer une équipe
            pour le projet 1</a> <em>Joel</em></li>
        <li><a href="evaluations/nouvelle?idSession=1&idModule=1">Créer
            une évaluation dans la session 1 pour le module 1</a>
          <em>Mickaël</em></li>
        <li><a href="notesSurMobile">Notes sur mobile</a>
          <em>Joel</em>
        </li>
        <li><a href="saisirNotes?idEvaluation=1">Saisir les notes
            de l'évaluation 1</a> <em>Jordan</em></li>
        <li><a href="gererPlanning">Gérer le planning</a> (client lourd)
          <em>Dovan</em></li>
        <li><a href="planning?idSession=1">Afficher le planning
          de la session de formation 1</a>
          <em>Dovan</em></li>
        <li><a href="feuilleDePresence?idSession=1&date=24-02-2016">Feuille
            de présence de la session 1 le 24/02/2016</a> <em>Lionel et
            Samuel</em></li>
        <li><a href="editerBulletin?idSession=1&idStagiaire=1">Editer
            le bulletin de notes du stagiaire 1 dans la session 1</a>
          <em>Bilanthini</em></li>
        <li><a href="creerSession?idFormation=1">Créer une session de
            formation pour la formation 1</a> <em>Sandrine</em>
        </li>
        <li><a href="gererFormation">Gérer les formations</a> (client lourd)
          <em>Jérôme</em>
        </li>
        <li><a href="creerFormateur">Créer un formateur</a> <em>Vincent</em></li>
      </ol>
    </section>
  </body>
</html>
