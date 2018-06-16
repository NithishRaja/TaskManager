<%-- 
    Document   : worker
    Created on : 16 Jun, 2018, 11:14:06 AM
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
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting worker info
            Statement stmt = con.createStatement();
            ResultSet worker = stmt.executeQuery("SELECT id, name, email, department_id FROM worker");
    %>
    <body>
        <%@include file="./nav.jsp"%>
        <section>
            <ul>
            <%while(worker.next()){
//                getting department name
                Statement stm = con.createStatement();
                ResultSet dept = stm.executeQuery("SELECT department_name FROM department WHERE id="+worker.getInt("department_id"));
            %>
            <li>
                <label>Name: </label><%=worker.getString("name")%>
                <label>Email: </label><%=worker.getString("email")%>
                <label>Department: </label><%=dept.next()?dept.getString("department_name"):""%>
            </li>
            <%}%>
        </section>
    </body>
    <%
        }catch(Exception e){
            System.out.println(e);
        }
    %>
</html>
