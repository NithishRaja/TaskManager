<%@page import="java.sql.*"%>
<%
//    cehcking if form is submitted
    if(request.getParameter("submit")!=null){
        try{
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");    
//        update task list with worker id
        Statement s=con.createStatement();
        String query = "UPDATE tasklist SET worker_id="
            +request.getParameter("worker")
            +", status=\"assigned\""
            +" WHERE id="+request.getParameter("task");
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