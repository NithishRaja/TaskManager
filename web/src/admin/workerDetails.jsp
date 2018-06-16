<%-- 
    Document   : workerDetails
    Created on : 16 Jun, 2018, 11:31:59 AM
    Author     : Nithish Raja.G
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%= request.getParameter("worker") %>
        <h1>Hello World!</h1>
    </body>
</html>
