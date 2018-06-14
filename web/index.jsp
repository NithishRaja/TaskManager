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
        <title>TASK MANAGER</title>
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
                    session.setAttribute("name", rs.getString("name"));
                    session.setAttribute("email", request.getParameter("email"));
                    if(rs.getString("isAdmin").equals("true")){
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", "./src/admin/index.jsp"); 
                    }else{
//                        TODO: redirect to worker page
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
        <header>
            <h1>
                Login
            </h1>
        </header>
        <section>
            <form method="POST">
                <div>
                    <label for="email">Email: </label>
                    <input type="text" id="email" name="email" placeholder="enter email"/>
                </div>
                <div>
                    <label for="password">Password: </label>
                    <input type="password" id="password" name="password" placeholder="enter password"/>
                </div>
                <input type="submit" name="submit" value="Login"/>
            </form>
        </section>
    </body>
</html>
