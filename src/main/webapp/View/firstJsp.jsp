<%@ page import="java.util.Date, world.ucode.Model.BlackAndWhite" %>
<%--
  Created by IntelliJ IDEA.
  User: oarnopolin
  Date: 18.10.20
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    Hallo
    <p>
        <%= new Date()%>
        <% BlackAndWhite tc = new BlackAndWhite(); %>
        <%= tc.getInfo() %>
        <br>
        <br>

    <h2>${requestScope.path}</h2>
    <img src="${requestScope.path}">
    </p>
    Pussy
</div>
</body>
</html>
