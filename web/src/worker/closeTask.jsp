<%@page import="java.sql.*"%>
<%
//    checking if close task form is submitted
    if(request.getParameter("close_task")!=null){
        try{
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");                    
//        updating task status to closed
        String query="UPDATE tasklist SET status=\"closed\" WHERE id="
            +request.getParameter("id");
        PreparedStatement ps=con.prepareStatement(query);
        int i = ps.executeUpdate();
        if(i > 0){
            System.out.print("Record Updated Successfully");
        }else{
            System.out.print("There is a problem in updating Record.");
        }            
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>