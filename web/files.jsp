<%-- 
    Document   : index
    Created on : 6 Jun, 2018, 10:37:31 AM
    Author     : Nithish Raja.G
--%>
<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="org.apache.commons.io.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="./static/css/bootstrap.min.css"/>
        <link rel="stylesheet" 
              href="./static/css/custom.css"/>
        <title>TASK MANAGER</title>
    </head>
<%
    if(session.getAttribute("status")!=null&&request.getParameter("file")!=null){
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting file details
            Statement stmt = con.createStatement();
            ResultSet file = stmt.executeQuery("SELECT * FROM files WHERE id="+request.getParameter("file")); 
            file.next();
//            seetting contentType and header
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\""+file.getString("filename")+"\"");
//            initializing PrintWriter
            PrintWriter output = response.getWriter();
//            initializing output stream
            FileInputStream fileInputStream = new FileInputStream(file.getString("filepath")+file.getString("filename"));
//            writing file
            int i;
            while ((i = fileInputStream.read()) != -1) {
		output.write(i);
            }
//            closing FileInputStream
            fileInputStream.close();
//            closing PrintWriter
            output.close();
//            closing connection
            con.close();            
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    }else{
%>
<body>
    <div class="jumbotron">
        <h1 class="display-4">Login to download file</h1>
        <hr class="my-4">
        <a class="btn btn-outline-info" href="./index.jsp">Go to login page</a>
    </div>
</body>
<%
    }
%>
</html>
