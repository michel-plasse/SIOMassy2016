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
    <form action="connexion" method="POST">
      Login
      <input type="text" name="login" value="${param['login']}"/>
      pwd
      <input type="password" name="password"/>
      <button type="submit">Connecter</button>
      ${loginMsg}
    </form>
  </body>
</html>
