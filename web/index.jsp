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
              href="./static/css/bootstrap.min.css"/>
        <title>TASK MANAGER</title>
    </head>
    <%
        try{
//        connecting to database
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/taskmanager", "root", "nithish98");            
//        getting department details
        Statement stm = con.createStatement();
        ResultSet dept = stm.executeQuery("SELECT * FROM department");
//        flag to toggle if credentials donot match
        int flag=1;
//        removing session variables if user logged out
        if(request.getParameter("logout")!=null){
            session.removeAttribute("name");
            session.removeAttribute("email");
            session.removeAttribute("id");
        }
//        checking if login form is submitted
        if(request.getParameter("submit")!=null){
            Statement stmt=con.createStatement();  
//            getting password for email
            ResultSet rs=stmt.executeQuery("SELECT * FROM worker WHERE email=\""+request.getParameter("email")+"\"");
//            checking password
            if(rs.next()&&request.getParameter("password").equals(rs.getString("password"))){
                System.out.println("login success");
                System.out.println(rs.getString("status"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("id", rs.getInt("id"));
                if(rs.getString("status").equals("DEO")){
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "./src/DEO/"); 
                }else if(rs.getString("status").equals("admin")){
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "./src/admin/"); 
                }else if(rs.getString("status").equals("employee")){
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "./src/worker/"); 
                }
            }else{
                flag=0;
            }           
        }
    %>
    <body class="container">
        <header>
            <h1>
                Login
            </h1>
        </header>
        <!-- Task entry section -->
        <section class="container">
            <form method="POST" action="./src/DEO/newTask.jsp">
                <div class="form-group">
                    <label for="department">Department: </label>
                    <select class="form-control"
                            name="department"
                            id="department">
                        <%while(dept.next()){%>
                        <option value="<%= dept.getInt("id") %>">
                            <%= dept.getString("department_name") %>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Description: </label>
                    <textarea class="form-control"
                              required 
                              name="description"
                              id="description"
                              placeholder="enter description here"></textarea>
                </div>
                <div class="form-group">
                    <label for="remarks">Remarks: </label>
                    <textarea class="form-control"
                              name="remarks"
                              id="remarks"
                              placeholder="enter remarks here"></textarea>
                </div>
                <div class="form-group">
                    <label for="date">Date: </label>
                    <input class="form-control"
                           required 
                           type="date" 
                           name="date"
                           id="date"/>
                </div>
                <%
                    if(session.getAttribute("message")!=null){
                %>
                    <div class="alert alert-info"><%=session.getAttribute("message")%></div>
                <%  
                    session.removeAttribute("message");
                    }else if(session.getAttribute("error")!=null){
                %>
                    <div class="alert alert-warning"><%=session.getAttribute("error")%></div>
                <%        
                    session.removeAttribute("error");
                    }
                %>
                <input class="btn btn-outline-success" type="submit" name="submit" value="add" />
            </form>
        </section>
        <!-- Login section -->
        <section>
            <form method="POST" action="./index.jsp">
                <div class="form-group">
                    <label for="email">Email: </label>
                    <input class="form-control"
                           required type="text"
                           id="email" name="email"
                           placeholder="enter email"/>
                </div>
                <div class="form-group">
                    <label for="password">Password: </label>
                    <input class="form-control"
                           required type="password"
                           id="password" name="password"
                           placeholder="enter password"/>
                </div>
                <%
                    if(flag==0){
                %>
                <div class="alert alert-warning">Incorrect email and password</div>
                <%
                    }
                %>
                <input class="btn btn-success" type="submit" name="submit" value="Login"/>
            </form>
        </section>
    </body>
    <%
//            closing database connection
            con.close();         
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e);
        }
    %>
</html>
