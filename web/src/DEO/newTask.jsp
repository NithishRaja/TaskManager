<%@page import="java.sql.*"%>
<%
//    checking if form is submitted
    if(request.getParameter("submit")!=null){
        try{
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
        con.close();
        session.setAttribute("message", "task inserted successfully");
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
            session.removeAttribute("message");
            session.setAttribute("error", "failed to insert task");
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>
