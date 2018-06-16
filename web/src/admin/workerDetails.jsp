<%-- 
    Document   : workerDetails
    Created on : 16 Jun, 2018, 11:31:59 AM
    Author     : Nithish Raja.G
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TASK MANAGER</title>
    </head>
    <%
        if(request.getParameter("worker")==null){
//            if worker is not mentioned redirect to index page
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", "./index.jsp");
        }
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting current worker details
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT * FROM worker WHERE id="+request.getParameter("worker"));
            worker.next();
//            getting department name of current worker
            Statement stm = con.createStatement();
            ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+worker.getInt("id"));
            dept.next();
    %>
    <body>
        <section>
            <ul>
                <li><label>Name: </label><%=worker.getString("name")%></li>
                <li><label>Email: </label><%=worker.getString("email")%></li>
                <li><label>Department: </label><%=dept.getString("department_name")%></li> 
            </ul>
        </section>
    </body>
    <%
//            closing connection
            con.close();
        }catch(Exception e){
            System.out.println(e);
        }
    %>
</html>
