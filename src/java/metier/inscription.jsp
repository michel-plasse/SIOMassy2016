<%-- 
    Document   : inscription
    Created on : 14 janv. 2016, 10:27:27
    Author     : jordan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inscription</title>
    </head>
    <body>
        <h1>Veuillez remplir les champs suivant</h1>
        <br </br>
        <h4>Tous les champs sont obligatoires sauf celui de la photo !</h4>
        <br </br>
        <br </br>
        <form action="ConnexionInscription" method="post">
        Adresse mail :
        <input type="email" name="mail" value="${param['mail']}">
        <br </br>
        <br </br>
        Password :
        <input type="password" name="password" value="${param['password']}">
        <br </br><!--
        Confirmer Password :
        <input type="password" name="confirmPwd" value="${param['confirmPwd']}"> -->
        <br </br>
        Numéro de téléphone :
        <input type="text" name="tel" value="${param['tel']}">
        <br </br>
        <br </br>
        Nom :
        <input type="text" name="nom" value="${param['nom']}">
        <br </br>
        <br </br>
        Prenom :
        <input type="text" name="prenom" value="${param['prenom']}">
        <br </br>
        <br </br>
        Ville :
        <input type="text" name="ville" value="${param['ville']}">
        <br </br>
        <br </br>
        Adresse :
        <input type="text" name="adresse" value="${param['adresse']}">
        <br </br>
        <br </br>
        Code Postal : 
        <input type="text" name="codePostal" value="${param['codePostal']}">
        <br </br>
        <br </br><!--
        Photo (lien de la photo) :
        <input type="file" name="photo" value="${param['photo']}">
        <br </br>
        <br </br>
                  -->
        <button type="submit">Valider</button>
        ${inscriptionMsg}
        </form>
    </body>
</html>
