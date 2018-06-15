<%-- 
    Document   : index
    Created on : 14 Jun, 2018, 8:00:59 PM
    Author     : Nithish Raja.G
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
//            redirect to login page if not logged in
            if(session.getAttribute("name")==null){
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", "./../../index.jsp");
            }
        %>
    </head>
    <body>
        <h1>DEO</h1>
    </body>
</html>
