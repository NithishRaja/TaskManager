<%@page import="java.sql.*"%>
<%@page import="commons.*"%>
<%
    System.out.println(request);
//    checking if start task form is submitted
    if(request.getParameter("start_task")!=null){
        try{
        Commons values = new Commons();
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//        updating task status to inprogress
        String query="UPDATE tasklist SET status=\"inprogress\" WHERE id="
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