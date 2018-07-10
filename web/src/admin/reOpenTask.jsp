<%@page import="java.sql.*"%>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<%@page import="commons.*"%>
<%
    if(request.getParameter("reOpen")!=null){
        try{
            Commons values = new Commons();
//            connecting to database
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection(values.getDatabaseUrl(), values.getDatabaseUsername(), values.getDatabasePassword());
//            move task back to inprogress
            String query = "UPDATE tasklist SET "
                    + "remarks=\""+request.getParameter("remarks")+"\","
                    + "status=\"open\""
                    + " WHERE id="+request.getParameter("task");
            PreparedStatement ps=con.prepareStatement(query);
            int i = ps.executeUpdate();
            if(i > 0){
                System.out.print("Record Updated Successfully");
            }else{
                System.out.print("There is a problem in updating Record.");
            }
//            closing connection
            con.close();
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    }
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", "./index.jsp");
%>