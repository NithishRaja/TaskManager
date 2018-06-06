<%-- 
    Document   : index
    Created on : 6 Jun, 2018, 10:37:31 AM
    Author     : Nithish Raja.G
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" 
              href="./static/css/bootstrap.css"/>
        <title>Login</title>
    </head>
    <%
        int flag=1;
        if(request.getParameter("submit")!=null){
            try {              
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
                Statement stmt=con.createStatement();  
                ResultSet rs=stmt.executeQuery("select * from employee");
               while(rs.next())  
                   System.out.println("name: "+rs.getString("name"));  
                con.close();  
            }catch(SQLException e) {
                out.println("SQLException caught: " +e.getMessage());
            }
        }
    %>
    <body class="container">
        <section>
            <form method="POST" action="index.jsp">
                <div class="form-group row">
                    <label for="email" class="col-form-label">Email: </label>
                    <div class="col-md-10">
                        <input type="email" class="form-control" id="email" name="email" placeholder="enter email here" />    
                    </div>
                </div>
                <div class="form-group row">
                    <label for="password" class="col-form-label">Password: </label>
                    <div class="col-md-10">
                        <input type="password" class="form-control" id="password" name="password" placeholder="enter password here"/>
                    </div>
                </div>
                <input type="submit" name="submit" class="btn btn-primary" value="Login"/>
            </form>
            <%
                if(flag==0){
            %>
            <div class="alert alert-warning" role="alert">iyviviui</div>    
            <%
                }
            %>
        </section>
    </body>
</html>
