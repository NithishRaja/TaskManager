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
//                connecting to database
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");
                Statement stmt=con.createStatement();  
//                getting password for email    
                ResultSet rs=stmt.executeQuery("SELECT name, password, isAdmin FROM employee WHERE email=\""+request.getParameter("email")+"\"");
//                checking password
                if(rs.next()&&request.getParameter("password").equals(rs.getString("password"))){
                    System.out.println("login success");
//                    TODO: redirect to diffrent page if isAdmin==1
                    session.setAttribute("name", rs.getString("name"));
                    session.setAttribute("email", request.getParameter("email"));
                    if(rs.getString("isAdmin").equals("true")){
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", "./src/admin/index.jsp"); 
                    }else{
                        System.out.println("not admin");
                    }
                }else{
                    flag=0;
                }
//                closing database connection
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
//                if login failed display error message
                if(flag==0){
            %>
            <div class="alert alert-warning" role="alert">Incorrect email or password</div>    
            <%
                }
            %>
        </section>
    </body>
</html>
