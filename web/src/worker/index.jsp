<%-- 
    Document   : index
    Created on : 6 Jun, 2018, 7:54:06 PM
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
        <%
            out.println(session.getAttribute("name"));
            out.println(session.getAttribute("email"));
        %>
    </body>
</html>
