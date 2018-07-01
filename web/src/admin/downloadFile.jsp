<%@page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="org.apache.commons.io.*" %>
<%
    if(session.getAttribute("status")!=null&&session.getAttribute("status").equals("admin")&&request.getParameter("file")!=null){
        try{
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//            getting file details
            Statement stmt = con.createStatement();
            ResultSet file = stmt.executeQuery("SELECT * FROM files WHERE id="+request.getParameter("file")); 
            file.next();
//            initializing source file
            File source = new File(file.getString("filepath")+file.getString("filename"));
//            getting home directory
            String home = System.getProperty("user.home");
//            initializing dest 
            File dest = new File(home+"/Downloads/");
//            copying source file into downloads directory
            FileUtils.copyFileToDirectory(source, dest);
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