<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%@page import="commons.*"%>
<%
    if(session.getAttribute("status")!=null&&session.getAttribute("status").equals("admin")&&request.getParameter("file")!=null){
        try{
            Commons values = new Commons();
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
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
    }
//    redirect to index page
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>