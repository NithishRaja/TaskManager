<%@page import="java.sql.*"%>
<%
//    checking if form is submitted
    if(request.getParameter("submit")!=null){
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
//        update table if form is submitted
        Statement stm = con.createStatement();
        String query = "INSERT INTO tasklist VALUES(null,null,"
            +request.getParameter("department")+","
            +"\""+request.getParameter("description")+"\","
            +"\""+request.getParameter("remarks")+"\",\"open\","
            +"\""+request.getParameter("date")+"\")";
        stm.executeUpdate(query);
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>
